clear

load file[data1.sav]

spool file[sample.out]

set pb1 = ic1/oc1
set pb2 = ic2/oc2
set pb3 = ic3/oc3
set pb4 = ic4/oc4
set pb5 = ic5/oc5

mnl dep[depvar] \
	ivalt[ic: ic1 ic2 ic3 ic4 ic5 \
	      pb: pb1 pb2 pb3 pb4 pb5] \
	prob[p2 p3 p4 p5]

set p1=1-p2-p3-p4-p5
cova var[p1 p2 p3 p4 p5]

spool off

