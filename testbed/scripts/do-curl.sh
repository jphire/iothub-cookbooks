#!/bin/bash

HOST="http://localhost" # e.g. hub1 for VM guests
FEED="/feeds/3"
TYPE="iothub"
NODETYPE="node"
DUKTAPETYPE="duktape"
JAVATYPE="java"
PORT="8080"
NODEPORT="3000"
JAVAPORT="9000"
DUKTAPEPORT="3030"
LOOPCOUNT="3"
METHOD="fibonacci-sm"
SCRIPT="$METHOD.js" # default to fibonacci script
IOTHUBUSER="anon"
CONF="iothub.conf"


function loopX {
	local total1=0 total2=0 total3=0 total4=0 total5=0 total6=0 total7=0 total8=0 total9=0 total10=0
    local total11=0 total12=0 total13=0 total14=0 total15=0
    local reqtime=0
    local i="0"
    local c=0
    local TYPE=$1
    local HOST=$2
    local PORT=$3
    local ADDR=$4
    local LOOPCOUNT=$5
    local SCRIPT=$6
    local METHOD=$7
    # local stamp=$(date +"%s")
    local filename=$METHOD-$TYPE.out
    local meanfilename=avg-$filename
	
	echo "Starting iot hub tests with hub: $HOST"
	echo "Clearing output file $filename..
	"
    # Clear the output file
    echo -n > $filename
    echo "HOST TYPE: $TYPE"
    echo "METHOD: $METHOD"
    echo "SCRIPT: $SCRIPT"
    echo "LOOPCOUNT: $LOOPCOUNT"
    echo "FULL OUTPUT FILE: $filename"
    echo "MEAN OUTPUT FILE: ../results/latest/$meanfilename"
    # IoT Hub curl test
    # Get curl output format from curl-log.txt. Consult that file to find out what is the meaning
    # of each column. The output format should be machine readable, for e.g. gnuplot.
    while [ $i -lt $LOOPCOUNT ]; do
        curl -XPOST \
            -H 'Content-Type:application/json' \
            -H 'Accept: application/json' \
            --data-binary @"$SCRIPT" \
            -w "@time-total-format.txt" \
            "$HOST:$PORT$ADDR" -s >>$filename
        i=$[$i+1]
        echo "Request $i / $LOOPCOUNT done"
    done

    # Print results to stdout in a convenient way, only mean is showed. To show total result listing, see
    # output files for each server
    echo "Results for $HOST:$PORT$ADDR"

    echo "________________________________________________________________________________________________________________________________"
    # echo "| Mean times                                                                                                     |"
    # echo "| ------------------------------------------------------------------------------------------------------------- |"

	# Get mean from each column and print it with awk.
    echo -n > "../results/latest/$meanfilename"

    # awk '{ total1+=$1; total2+=$2; total3+=$3; total4+=$4; total5+=$5; total6+=$6; total7+=$7; total8+=$8; total9+=$9; total10+=$10; reqtime+=$11; c++ } \
    #     END { printf "%f\t%f\t%i\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n", total1/c,reqtime/c*1000,c,total2/c,total3/c,total4/c,total5/c,total6/c,total7/c,total8/c,total9/c,total10/c}' "$filename" >>"$meanfilename"

    awk '{ total1+=$1; total2+=$2; total3+=$3; total4+=$4; total5+=$5; total6+=$6; total7+=$7; total8+=$8; total9+=$9; total10+=$10; reqtime+=$11; c++ } \
        END { printf "%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n", total1/c,total2/c,total3/c,total4/c,total5/c,total6/c,total7/c,total8/c,total9/c,total10/c}' "$filename" >>"../results/latest/$meanfilename"

    rm "$filename"
	echo "--------------------------------------------------------------------------------------------------------------------------------"
}

while [[ $# > 0 ]]; do
key="$1"

case $key in
    -h|--host) # which iothub instance to send to
    HOST="$2"
    shift
    ;;
    -n|--loopcount) # amount of requests to be send
    LOOPCOUNT="$2"
    shift
    ;;
    --port) # iothub server port
    PORT="$2"
    shift
    ;;
    --nodeport) # nodejs server port
    NODEPORT="$2"
    shift
    ;;
    --javaport) # java server port
    JAVAPORT="$2"
    shift
    ;;
    --duktapeport) # java server port
    DUKTAPEPORT="$2"
    shift
    ;;
    --use-iothub)
    PORT="$PORT"
    TYPE="iothub"
    shift
    ;;
    --use-node)
    PORT="$NODEPORT"
    TYPE="node"
    shift
    ;;
    --use-java)
    PORT="$JAVAPORT"
    TYPE="java"
    shift
    ;;
    --use-duktape)
    PORT="$DUKTAPEPORT"
    TYPE="duktape"
    shift
    ;;
    --script)
    SCRIPT="$2"
    shift
    ;;
    --method)
    METHOD="$2"
    shift
    ;;
    --conf)
    CONF="$2"
    shift
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
        # unknown option
    ;;
esac
shift # past argument or value
done

if [ -r "$CONF" ]; then
  echo "Reading user config for iothub from file $CONF...." >&2
  . "$CONF"
fi


loopX $TYPE $HOST $PORT $FEED $LOOPCOUNT $SCRIPT $METHOD

echo -n >"../results/latest/$METHOD/$TYPE.dat"
paste "$METHOD-numbers" "../results/latest/avg-$METHOD-$TYPE.out"  >>"../results/latest/$METHOD/$TYPE.dat"


