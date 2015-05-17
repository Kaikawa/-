clear

load file[data1.sav]

spool file[frcst.out]

set one=1
set zero=0

mnl dep[depvar] \
	ivalt[ic: ic1 ic2 ic3 ic4 ic5 \
	      oc: oc1 oc2 oc3 oc4 oc5  \
              c1: one zero zero zero zero \
              c2: zero one zero zero zero \
              c3: zero zero one zero zero \
              c4: zero zero zero one zero ]  \
	coef[beta]

set v1=beta[1]*ic1 + beta[2]*oc1 + beta[3] 
set v2=beta[1]*ic2 + beta[2]*oc2 + beta[4]
set v3=beta[1]*ic3 + beta[2]*oc3 + beta[5]
set v4=beta[1]*ic4 + beta[2]*oc4 + beta[6]
set v5=beta[1]*ic5 + beta[2]*oc5 

set denom=exp(v1)+exp(v2)+exp(v3)+exp(v4)+exp(v5)

set p1=exp(v1)/denom
set p2=exp(v2)/denom
set p3=exp(v3)/denom
set p4=exp(v4)/denom
set p5=exp(v5)/denom

cova var[p1 p2 p3 p4 p5]

spool off

