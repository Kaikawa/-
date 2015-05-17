clear

load file[data1.sav]

spool file[sample2.out]

mnl dep[depvar] \
	ivalt[ic: ic1 ic2 ic3 ic4 ic5 \
	      oc: oc1 oc2 oc3 oc4 oc5] \
	prob[p2 p3 p4 p5]
set p1=1-p2-p3-p4-p5
cova var[p1 p2 p3 p4 p5]

set lcc1=ic1 + (1/.12)*oc1
set lcc2=ic2 + (1/.12)*oc2
set lcc3=ic3 + (1/.12)*oc3
set lcc4=ic4 + (1/.12)*oc4
set lcc5=ic5 + (1/.12)*oc5

mnl dep[depvar] \
	ivalt[lcc: lcc1 lcc2 lcc3 lcc4 lcc5 ] 

set zero=0
set one=1

mnl dep[depvar] \
    ivalt [ ic: ic1 ic2 ic3 ic4 ic5 \
            oc: oc1 oc2 oc3 oc4 oc5 \
            c1: one zero zero zero zero \
            c2: zero one zero zero zero \
            c3: zero zero one zero zero \
            c4: zero zero zero one zero ] \
     prob[p2 p3 p4 p5]

set p1=1-p2-p3-p4-p5
cova var[p1 p2 p3 p4 p5]

set ici1=ic1 / income
set ici2=ic2 / income
set ici3=ic3 / income
set ici4=ic4 / income
set ici5=ic5 / income

mnl dep[depvar] \
    ivalt [ ici: ici1 ici2 ici3 ici4 ici5 \
            oc: oc1 oc2 oc3 oc4 oc5 \
            c1: one zero zero zero zero \
            c2: zero one zero zero zero \
            c3: zero zero one zero zero \
            c4: zero zero zero one zero ] 

mnl dep[depvar] \
    ivalt [ ic: ic1 ic2 ic3 ic4 ic5 \
            oc: oc1 oc2 oc3 oc4 oc5 \
            c1: one zero zero zero zero \
            c2: zero one zero zero zero \
            c3: zero zero one zero zero \
            c4: zero zero zero one zero \
            i1: income zero zero zero zero \
            i2: zero income zero zero zero \
            i3: zero zero income zero zero \
            i4: zero zero zero income zero ]


spool off

