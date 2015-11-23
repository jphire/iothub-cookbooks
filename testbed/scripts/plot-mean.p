set encoding utf8
set term svg
#set term pdfcairo enhanced color solid font "Helvetica,24" linewidth 1.5 dashlength 1.5 size 6in,4in
#set terminal postscript portrait enhanced mono dashed lw 1 "Helvetica" 14

#set style data yerrorlines
set style line 1 lc rgb "#000064" lw 2.0 ps 1.5 pi 3
set style line 2 lc rgb "#2B00FF" lw 2.0 ps 1.5 pi 3
set style line 3 lc rgb "#C72BD6" lw 2.0 ps 1.5 pt 7 pi 3
set style line 4 lc rgb "#FF8C73" lw 2.0 ps 1.5 pi 3
#set style line 5 lc rgb "#000000" lw 0.5 ps 0

set key top center

set ylabel "no label"
set xlabel "Fibonacci number"

set output 'results.svg'
f(x) = x**x

set xrange [22:32]

plot 'plot.dat' u 1:(1) t 'Iothub' ls 2,\
'' u 1:($2/$3) t 'Node' ls 3,\
'' u 1:($2/$4) t 'Duktape' ls 4

#plot 'mean-fibonacci-iothub.out' u 1:($1/1000) t 'IotHub times' ls 1,\
unset output
reset
