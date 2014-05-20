set term x11

# define colors
# http://www.uni-hamburg.de/Wiss/FB/15/Sustainability/schneider/gnuplot/colors.htm
# http://www.yellowpipe.com/yis/tools/hex-to-rgb/color-converter.php
# http://web.forret.com/tools/color.asp?R=255&G=69&B=0
set style line 1 lt 1 lc rgb "black"    lw 5
set style line 2 lt 1 lc rgb "#ff4500"  lw 5 #orangered
set style line 3 lt 1 lc rgb "#0e21e1"  lw 5 #violet
set style line 4 lt 1 lc rgb "#ff8c00"  lw 5 #darkorange
set style line 5 lt 1 lc rgb "#9932cc"  lw 5 #darkorchid
set style line 6 lt 1 lc rgb "#dd0000"  lw 5 #darkred
set style line 7 lt 1 lc rgb "#7b68ee"  lw 5 #mediumslateblue
set style line 8 lt 1 lc rgb "cyan"  lw 5 
#set style line 8 lt 1 lc rgb "#800000"  lw 5 #maroon
set style line 9 lt 1 lc rgb "navy"     lw 5
set style line 10 lt 1 lc rgb "#008000" lw 5 #green

set style line 11 lt 2 lc rgb "black"   lw 5
set style line 12 lt 2 lc rgb "#ff4500" lw 5 #orangered
set style line 13 lt 2 lc rgb "#0e21e1" lw 5 #latex violet
set style line 14 lt 2 lc rgb "#ff8c00" lw 5 #darkorange
set style line 15 lt 2 lc rgb "#9932cc" lw 5 #darkorchid
set style line 16 lt 2 lc rgb "#dd0000" lw 5 #darkred
set style line 17 lt 2 lc rgb "#7b68ee" lw 5
set style line 18 lt 2 lc rgb "#800000" lw 5 #maroon
set style line 19 lt 2 lc rgb "navy"    lw 5
set style line 20 lt 2 lc rgb "#008000" lw 5 #green

set style line 21 lt 3 lc rgb "black"   lw 5
set style line 22 lt 3 lc rgb "#ff4500" lw 5 #orangered
set style line 23 lt 3 lc rgb "#0e21e1" lw 5 #latex violet
set style line 24 lt 3 lc rgb "#ff8c00" lw 5 #darkorange
set style line 25 lt 3 lc rgb "#9932cc" lw 5 #darkorchid
set style line 26 lt 3 lc rgb "#dd0000" lw 5 #darkred
set style line 27 lt 3 lc rgb "#7b68ee" lw 5
set style line 28 lt 3 lc rgb "#800000" lw 5 #maroon
set style line 29 lt 3 lc rgb "navy"    lw 5
set style line 30 lt 3 lc rgb "#008000" lw 5 #green

set macros
MATLAB = "defined (0  0.0 0.0 0.5, \
                   1  0.0 0.0 1.0, \
                   2  0.0 0.5 1.0, \
                   3  0.0 1.0 1.0, \
                   4  0.5 1.0 0.5, \
                   5  1.0 1.0 0.0, \
                   6  1.0 0.5 0.0, \
                   7  1.0 0.0 0.0, \
                   8  0.5 0.0 0.0 )"
