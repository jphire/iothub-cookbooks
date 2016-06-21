set encoding utf8

set terminal svg
#set terminal latex

#set term pdfcairo enhanced color solid font "Helvetica,24" linewidth 1.5 dashlength 1.5 size 6in,4in
#set terminal postscript portrait enhanced mono dashed lw 1 "Helvetica" 14

#set style data yerrorlines
set style func linespoints
set style line 1 lc rgb "#000064" lw 1.5 ps 1.0 pi 1
set style line 2 lc rgb "#2B00FF" lw 1.5 ps 1.0 pi 1
set style line 3 lc rgb "#C72BD6" lw 1.5 ps 1.0 pt 7 pi 1
set style line 4 lc rgb "#FF8C73" lw 1.5 ps 1.0 pi 1
set style line 5 lc rgb "#CCCCCC" lw 1.5 ps 1.0 pi 1

set key top right

set ylabel "Performance factors"
set y2label "Kahvihub execution time (ms)"
set xlabel "Array size"

#set output '../../results/latest/plot/quicksort.tex'
#set output '~/Opiskelu/GitGradu/gradu/quicksort.svg'
set output '../../results/latest/plot/quicksort.svg'


set size 1.0, 1.0

set xrange [5000:50000]
set x2range [5000:50000]
set yrange [1:200]
set y2range [1:20000]

set logscale y 2

set grid x y

set xtics 5000
set xtics nomirror
set ytics nomirror
set ytics 20
set y2tics 2000

set title "Quicksort"

plot '../../results/latest/quicksort.dat' u 1:(1) with linespoints t 'Kahvihub' ls 2, \
'' u 1:($3/$2) with linespoints t 'Duktape-node' ls 3, \
'' u 1:($3/$4) with linespoints t 'Plain NodeJS' ls 4, \
'' u 1:($3/$5) with linespoints t 'Solmuhub' ls 5,


# '../../results/latest/quicksort/kahvihub.dat' using 1:2 axes x1y2 with lines t '' ls 5

unset output
reset