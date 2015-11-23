#!/bin/bash


# types=( "iothub" "duktape" "node" )
# methods=( "fibonacci" "quicksort" "newton" )
types=( "iothub" "node" "duktape")
methods=( "fibonacci")

echo -n > plot.dat

for m in "${methods[@]}";
do
    for t in "${types[@]}";
    do
        if [ "$t" == "duktape" ];
        then
            SCRIPT="$m-nocall.js"
        else
            SCRIPT="$m-sm.js"
        fi

        # echo "./do-curl.sh --method $m --script $SCRIPT --conf $t.conf"
        ./do-curl.sh -n 5 --method $m --script $SCRIPT --conf $t.conf
    done
    # awk '{ total1+=$1; total2+=$2; total3+=$3; total4+=$4; total5+=$5; total6+=$6; total7+=$7; total8+=$8; total9+=$9; total10+=$10; reqtime+=$11; c++ } \
    #     END { printf "%f\t%f\t%i\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n", total1/c,reqtime/c*1000,c,total2/c,total3/c,total4/c,total5/c,total6/c,total7/c,total8/c,total9/c,total10/c}' "$filename" >>"$meanfilename"
done

paste fibonacci-numbers mean-fibonacci-iothub.out mean-fibonacci-node.out mean-fibonacci-duktape.out >plot.dat

# paste quicksort-numbers mean-quicksort-iothub.out mean-quicksort-node.out mean-quicksort-duktape.out >plot2.dat

# paste newton-numbers mean-newton-iothub.out mean-newton-node.out mean-newton-duktape.out >plot3.dat

# for m in "${methods[@]}";
# do
#     for col in `seq 1 10`;
#     do
#         for t in "${types[@]}";
#         do
            
#         done   
#     done
# done

