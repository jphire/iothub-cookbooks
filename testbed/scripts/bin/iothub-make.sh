#!/bin/bash

# This shell script executes all the algorithms on every type of hub, and outputs results under the 'latest'
# directory. Old results in latest are saved and moved under a timestamped directory in 'results' folder, so the timestamp
# indicates when they have been moved there, not the date that the tests in those folders where run. Possibly the next former
# timestamped folder in results is the timestamp of the next newer tests.. pretty complicated but.. yeah. 

types=( "kahvihub" "node" "duktape" "solmuhub")
methods=( "fibonacci" "quicksort" "newton")

time_stamp=$(date +"%s")
NEWDIR=$time_stamp
TEMPLATE_DIR=templates
BIN_DIR=bin

mkdir -p ../results/$NEWDIR
mv ../results/latest/* ../results/$NEWDIR

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
        ./$BIN_DIR/do-curl.sh -n 5 --method $m --script $SCRIPT --conf $t.conf
    done
    # Uncomment to save intermediate results to files, for debugging
    # awk '{ total1+=$1; total2+=$2; total3+=$3; total4+=$4; total5+=$5; total6+=$6; total7+=$7; total8+=$8; total9+=$9; total10+=$10; reqtime+=$11; c++ } \
    #     END { printf "%f\t%f\t%i\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n", total1/c,reqtime/c*1000,c,total2/c,total3/c,total4/c,total5/c,total6/c,total7/c,total8/c,total9/c,total10/c}' "$filename" >>"$meanfilename"
done


paste $TEMPLATE_DIR/fibonacci-numbers ../results/latest/mean-fibonacci-kahvihub.out ../results/latest/mean-fibonacci-node.out ../results/latest/mean-fibonacci-duktape.out >../results/latest/fibonacci.dat

paste $TEMPLATE_DIR/quicksort-numbers ../results/latest/mean-quicksort-kahvihub.out ../results/latest/mean-quicksort-node.out ../results/latest/mean-quicksort-duktape.out >../results/latest/quicksort.dat

paste $TEMPLATE_DIR/newton-numbers ../results/latest/mean-newton-kahvihub.out ../results/latest/mean-newton-node.out ../results/latest/mean-newton-duktape.out >../results/latest/newton.dat

