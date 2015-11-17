#!/bin/bash

HOST="http://localhost" # e.g. hub1 for VM guests
TYPE="IOTHUB"
FEED="/feeds/3"
FILE="iothub-server"
NODEFILE="node-server"
JAVAFILE="java-server"
PORT="8080"
NODEPORT="3000"
JAVAPORT="9000"
LOOPCOUNT="3"
SCRIPT="fibonacci-small.js" # default is fibonacci script
TEST="fibonacci"


function loopX {
	local total1=0 total2=0 total3=0 total4=0 total5=0 total6=0 total7=0 total8=0 total9=0 total10=0
    local reqtime=0
	local filename=$7-$1.txt
	local i="0"
	local c=0
    local FILE=$1
	local HOST=$2
	local PORT=$3
	local ADDR=$4
    local LOOPCOUNT=$5
    local SCRIPT=$6
    local TEST=$7
	
	echo "Starting iot hub tests with hub: $HOST"
	echo "Clearing output file $filename..
	"
    echo -n > $filename
    echo "HOST TYPE: $TYPE"
    echo "METHOD: $SCRIPT"
    echo "LOOPCOUNT: $LOOPCOUNT"

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
            # awk '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6*1000}'
        i=$[$i+1]
        echo "Request $i / $LOOPCOUNT done"
    done

    # Print results to stdout in a convenient way, only mean is showed. To show total result listing, see
    # output files for each server
    echo "Results for $HOST:$PORT$ADDR"
	# echo "_________________________________________________________________________________________________________________"
	# echo "| Namelookup 	Connect 	Appconnect 	Pretransfer 	Redirect 	Starttransfer 	| Total 	|"
	# echo "| ------------------------------------------------------------------------------------------------------------- |"
	# Uncomment the row below to show full result listing in addition to the mean results.
    # cat "$filename"

    echo "________________________________________________________________________________________________________________________________"
    # echo "| Mean times                                                                                                     |"
    # echo "| ------------------------------------------------------------------------------------------------------------- |"

	# Get mean from each column and print it with awk. Mean results are multiplied by 1000 to get milliseconds.
	
    # FIBONACCI
 #    awk '{ total1+=$1; total2+=$3; total3+=$5; total4+=$7; total5+=$9; total6+=$11; total7+=$13; total8+=$15; total9+=$17; total10+=$19; reqtime+=$20; c++ } \
	# END { printf "| %f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t|  %f  |\n", total1/c,total2/c,total3/c,total4/c,total5/c,total6/c,total7/c,total8/c,total9/c,total10/c,reqtime/c*1000}' "$filename"

    # FIBONACCI SMALL
    awk '{ total1+=$1; total2+=$3; total3+=$5; total4+=$7; total5+=$9; total6+=$11; total7+=$13; total8+=$14; total9+=$14; total10+=$14; reqtime+=$14; c++ } \
    END { printf "| %f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t|  %f  |\n", total1/c,total2/c,total3/c,total4/c,total5/c,total6/c,total7/c,total8/c,total9/c,total10/c,reqtime/c*1000}' "$filename"


    # QUICKSORT
    # awk '{ total1+=$1; total2+=$3; total3+=$5; total4+=$7; total5+=$9; total6+=$11; total7+=$13; total8+=$15; total9+=$17; total10+=$19; reqtime+=$20; c++ } \
    # END { printf "| %f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t|  %f  |\n", total1/c,total2/c,total3/c,total4/c,total5/c,total6/c,total7/c,total8/c,total9/c,total10/c,reqtime/c*1000}' "$filename"


    # NEWTON'S METHOD
    # awk '{ total1+=$1; total2+=$3; total3+=$5; total4+=$7; total5+=$9; total6+=$11; total7+=$13; total8+=$15; total9+=$17; total10+=$19; reqtime+=$20; c++ } \
    # END { printf "| %f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t|  %f  |\n", total1/c,total2/c,total3/c,total4/c,total5/c,total6/c,total7/c,total8/c,total9/c,total10/c,reqtime/c*1000}' "$filename"
    # 
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
    --file) # iothub results output file
    FILE="$2"
    shift
    ;;
    --nodefile) # node results output file
    NODEFILE="$2"
    shift
    ;;
    --javafile) # java results output file
    JAVAFILE="$2"
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
    --use-iothub)
    PORT="$PORT"
    FILE="$FILE"
    TYPE="IOTHUB"
    shift
    ;;
    --use-node)
    PORT="$NODEPORT"
    FILE="$NODEFILE"
    TYPE="NODE"
    shift
    ;;
    --use-java)
    PORT="$JAVAPORT"
    FILE="$JAVAFILE"
    TYPE="JAVA"
    shift
    ;;
    --script)
    SCRIPT="$2"
    shift
    ;;
    --test)
    TEST="$2"
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

loopX $FILE $HOST $PORT $FEED $LOOPCOUNT $SCRIPT $TEST


#  Alternative way to count
# for i in $( awk '{ print $1 }' out.txt ); do 
# 	total1=$(echo $total1+$i | bc )
# 	((count++))
# done
# echo "scale=4; $total1 / $count" | bc


