#!/bin/bash

HUB="hub1"
PORT="8080"
LOOPCOUNT="1"
i="0"
count=0
total1=0
total2=0 


if [ ! -z "$1" ]; then
	HUB=$1
    # echo "Usage: ./curl-test [hubName] [loopCount] [port]"
fi

if [ ! -z "$2" ]; then
	LOOPCOUNT=$2
fi

echo "Starting iot hub tests with hub: $HUB.."
echo "
"

echo "" > out.txt

while [ $i -lt $LOOPCOUNT ]; do
  curl -w "@curl-log.txt" -o response.json -s "$HUB:$PORT/feeds/1" >>out.txt
  i=$[$i+1]
done

echo "Namelookup 	Connect 	Appconnect 	Pretransfer 	Redirect 	Starttransfer 	| Total"
echo "-------------------------------------------------------------------------------------------------------"
cat out.txt
echo "-------------------------------------------------------------------------------------------------------"

# for i in $( awk '{ print $1 }' out.txt ); do 
# 	total1=$(echo $total1+$i | bc )
# 	((count++))
# done
# echo "scale=4; $total1 / $count" | bc

awk '{ total1+=$1; total2+=$2; total3+=$3; total4+=$4; total5+=$5; total6+=$6; total7+=$8; c++ } \
END { printf "%f\t%f\t%f\t%f\t%f\t%f\t| %f", total1/c,total2/c,total3/c,total4/c,total5/c,total6/c,total7/c }' out.txt


echo "
"

