#!/bin/bash

HUB="hub1"
FILE="iothub"
NODEFILE="nodefile"
JAVAFILE="javafile"
PORT="8080"
NODEPORT="3000"
JAVAPORT="9000"
LOOPCOUNT="1"


function loopX {
	local total1=0 total2=0 total3=0 total4=0 total5=0 total6=0 total7=0
	local filename=out-$1.txt
	local i="0"
	local c=0
	local HOST=$2
	local PORT=$3
	local ADDR=$4
	
	echo "Starting iot hub tests with hub: $HOST.."
	echo "Clearing output file $filename..
	"
	echo "" > $filename

	# IoT Hub curl test
	# Get curl output format from curl-log.txt. Consult that file to find out what is the meaning
	# of each column. The output format should be machine readable, for e.g. gnuplot
	while [ $i -lt $LOOPCOUNT ]; do
	  curl -w "@curl-log.txt" -o response.json -s "$HOST:$PORT$ADDR" >>$filename
	  i=$[$i+1]
	done

	# Print results to stdout in a convenient way, only mean is showed. To show total result listing, see
	# output files for each server
	echo "Results for $HOST:$PORT$ADDR"
	echo "_________________________________________________________________________________________________________________"
	echo "| Namelookup 	Connect 	Appconnect 	Pretransfer 	Redirect 	Starttransfer 	| Total 	|"
	echo "| ------------------------------------------------------------------------------------------------------------- |"
	# cat "$filename"
	# echo "-------------------------------------------------------------------------------------------------------"

	# Get mean from each column and print it with awk
	awk '{ total1+=$1; total2+=$2; total3+=$3; total4+=$4; total5+=$5; total6+=$6; total7+=$8; c++ } \
	END { printf "| %f\t%f\t%f\t%f\t%f\t%f\t| %f\t|\n", total1/c,total2/c,total3/c,total4/c,total5/c,total6/c,total7/c }' "$filename"

	echo "-----------------------------------------------------------------------------------------------------------------"
}

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -h|--hub) # which iothub instance to send to
    HUB="$2"
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
    --default)
    DEFAULT=YES
    ;;
    *)
        # unknown option
    ;;
esac
shift # past argument or value
done

loopX $FILE $HUB $PORT "/" $LOOPCOUNT
# loopX $NODEFILE $HUB $NODEPORT "/" $LOOPCOUNT
# loopX $JAVAFILE $HUB $JAVAPORT "/" $LOOPCOUNT

#  Alternative way to count
# for i in $( awk '{ print $1 }' out.txt ); do 
# 	total1=$(echo $total1+$i | bc )
# 	((count++))
# done
# echo "scale=4; $total1 / $count" | bc


