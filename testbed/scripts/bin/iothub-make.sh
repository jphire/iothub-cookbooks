#!/bin/bash

# This shell script executes all the algorithms on every type of hub, and outputs results under the 'latest'
# directory. Old results in latest are saved and moved under a timestamped directory in 'results' folder, so the timestamp
# indicates when they have been moved there, not the date that the tests in those folders where run. Possibly the next former
# timestamped folder in results is the timestamp of the next newer tests.. pretty complicated but.. yeah. 

types=( "kahvihub" "node" "duktape" "solmuhub")
methods=( "fibonacci" "quicksort" "newton")
times=1

time_stamp=$(date +"%s")
pretty_date=$(date -d @$time_stamp)
BACKUPDIR=$time_stamp
TEMPLATE_DIR=templates
BIN_DIR=bin

mkdir -p ../../results/$BACKUPDIR
mv ../../results/latest/* ../../results/$BACKUPDIR

touch "../../results/latest/TEST-SPEC"
printf "Test was generated at: %s\nLoop times: %d\n" "$pretty_date" "$times" >>../../results/latest/TEST-SPEC

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
        ./do-curl.sh -n $times --method $m --script $SCRIPT --conf $t.conf
    done
    # Uncomment to save intermediate results to files, for debugging
    # awk '{ total1+=$1; total2+=$2; total3+=$3; total4+=$4; total5+=$5; total6+=$6; total7+=$7; total8+=$8; total9+=$9; total10+=$10; reqtime+=$11; c++ } \
    #     END { printf "%f\t%f\t%i\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n", total1/c,reqtime/c*1000,c,total2/c,total3/c,total4/c,total5/c,total6/c,total7/c,total8/c,total9/c,total10/c}' "$filename" >>"$meanfilename"
done

mkdir -p ../../results/latest/plot

for method in "${methods[@]}";
do
    if [ ! -e "../../results/latest/$method.dat" ] ; then 
        touch "../../results/latest/$method.dat"
    fi
    paste ../$TEMPLATE_DIR/$method-numbers ../../results/latest/avg-$method-kahvihub.out ../../results/latest/avg-$method-node.out \
    ../../results/latest/avg-$method-duktape.out ../../results/latest/avg-$method-solmuhub.out >../../results/latest/$method.dat

    gnuplot ../plot/plot-$method.p
done

