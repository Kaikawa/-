new , 10000;
screen on;
output file=out4.txt reset;
print "This program estimates a mixed logit with fixed price coef, uniform known coef, and normal for the other coefficients.";
nobs = 4308;              @Number of choice situations.@
nalt = 4;                 @Number of alternatives in each choice situation.@
np=361;                   @Number of people (each facing multiple choice situations)@

load xmat[nobs,28]=xdata; @Expl variables: 7 vars for each of 4 alts. Only 6 are used below.@
load yvec[nobs,1]=ydata;  @Chosen alternative@
load times[np,1]=times;   @Number of choice situations faced by each person.@

nvar=6;                   @Number of explanatory variables included in model.@
@Rearrange expl vars to make a matrix with nobs*nalt rows and nvar columns@
v1=reshape(xmat[.,1:4],nobs*nalt,1);   @Price in c/kwh, or zero for nonfixed rates@
v2=reshape(xmat[.,5:8],nobs*nalt,1);   @Contract length in years@
v3=reshape(xmat[.,9:12],nobs*nalt,1);  @Local company (0-1 dummy)@
v4=reshape(xmat[.,13:16],nobs*nalt,1); @Known company (0-1 dummy)@
v5=reshape(xmat[.,21:24],nobs*nalt,1); @TOD rates (0-1 dummy)@
v6=reshape(xmat[.,25:28],nobs*nalt,1); @Seasonal rates (0-1 dummy)@
vars=v1~v2~v3~v4~v5~v6;   @vars has dimensions: nalt*nobs by nvar@
clear xmat, v1, v2, v3, v4, v5, v5; @To save memory.@
nrep=100;                 @Number of draws to use in simulation.@
seed1=46;                 @Seed to use in making draws.@

@starting values in this order: fixed coef for price, mean and std dev for length and@
@ local, parameter for upper limit of uniform coef for known, and mean and std dev for TOD @
@ So starting value for parameter of known coef is the sixth element in parameter vector.@
b={-.857, -.183, 0.1, 2.098, 1. , 3.0, -8.285, 2.0, -8.53, 2.0};

@Specify cross-section versus panel: cvp=1 for cross-sect, =2 for panel.@
cvp=2;

@Call maxlik, specify its globals, and do estimation.@
xx=ones(nobs,1);          @to use in maxlik@
library maxlik,pgraph;
#include maxlik.ext;
maxset;
_max_GradTol=0.005;
_max_MaxIters=50;
_max_Algorithm=2; 
if cvp .eq 1;
print "Cross-sectional estimation.";
{beta,f,g,cov,ret}=maxlik(xx,0,&llc,b);
elseif cvp .eq 2;
print "Panel estimation.";
{beta,f,g,cov,ret}=maxlik(xx,0,&llp,b);
else;
print "You need to specify cross-sectional or panel.";
endif;
call maxprt(beta,f,g,cov,ret);



/*Log-Likelihood routine treating each obs as independent (ie, for cross-sectional data).*/
proc llc(b,x);
@uses globals nobs,nalt,yvec,nvar,vars,nrep,seed1@
local p,m,s,n,seed2,err,beta,ev,r;
p=zeros(nobs,1);                    @Probability for each observation.@
n=zeros(1,1);                       @Zero for sd of the price coef. and additive term for known coef.@
b=b[1,.]|n|b[2:5,.]|n|b[6:rows(b),.];  @Add the zeros to the parameter vector.@
b=reshape(b,nvar,2);                @Parameters with means in col 1, stds in col 2@
m=b[.,1];                           @Means@
s=b[.,2];                           @Standard deviations@
seed2=seed1;                        @To reset seed for each call of ll proc@
n=1;                                @To loop over observations.@
do while n .le nobs;
     err=rndns(nvar,nrep,seed2);    /*Draw standard normals. Matrix err is nvar by nrep, 
                                    ie, one normal deviate for each of the nvar explanatory
                                    variables for each of the nrep draws. Note that seed2 is 
                                    reset automatically by gauss after each call 
                                    of rndns. The new value of seed2 is overridden if
                                    seed2 is reset explicitly by the code as in the third
                                    line above. By having gauss reset seed2 with each new n, 
                                    we get different draws for different obs. But by resetting
                                    seed2 explicitly with each new call of the ll proc, we get 
                                    the same sequence of draws (ie draws for all people) each
                                    time the ll is calculated. */
     err[4,.]=rndus(1,nrep,seed2);  @Draw uniforms for known coefficient, overriding normal.@
     beta=m+s.*err;                 /*Calculate the coefficients for each set of draws of 
                                    standard normals. This gives nrep sets of coefficient: 
                                    beta is nvar x nrep*/
     ev=vars[(n-1)*nalt+1:n*nalt,.];@Extract explanatory vars for this obs: nalt x nvar@
     ev=exp(ev*beta);               @Matrix multiply vars by coefficients and exp: nalt x nrep@
     r=ev[yvec[n,1],.] ./sumc(ev)'; @Calc logit prob for each set of draws: 1 x nrep@
     p[n,1]=meanc(r');              @Simulated prob is average of logit prob over draws)@  
     n=n+1;
endo;
retp(ln(p));
endp;


/*Log-Likelihood routine for panel data.*/
proc llp(b,x);
@uses globals nobs,nalt,np,xmat,yvec,times,nrep,seed1,nvar@
local p,m,s,n,count,seed2,err,beta,ev,t,r,q;
p=zeros(np,1);           @Probability for np people's sequence of choices@
n=zeros(1,1);            @Zero for sd of the price coef. and additive term for known coef.@
b=b[1,.]|n|b[2:5,.]|n|b[6:rows(b),.];  @Add the zeros to the parameter vector.@
b=reshape(b,nvar,2);
m=b[.,1];                @Means@
s=b[.,2];                @Standard deviations@
n=1;                     @To loop over people.@
count=0;                 @Number of observations before n-th person.@
seed2=seed1;
do while n .le np;
     err=rndns(nvar,nrep,seed2);
     err[4,.]=rndus(1,nrep,seed2);  @Draw uniforms for known coefficient, overriding normal.@
     beta=m+s.*err;      @Draws of random coefficients: nvar x nrep@
     ev=vars[count*nalt+1:(count+times[n,1])*nalt,.];  @Extract vars for this person: times*nalt by nvar@
     ev=exp(ev*beta);    @ev is times*nalt by nrep@
     t=1;                @To loop over choice situations that this person faced.@
     r=ones(1,nrep);     @Hold probability for this person's sequence of choices (one for each draw)@
     do while t .le times[n,1];
        q=ev[(1+ nalt*(t-1)):(nalt*t),.];  @ev's for one choice situation: nalt by nrep@ 
        q=q[yvec[count+t,.],.] ./ sumc(q)';  @prob for that choice situation: 1 by nrep@
        r=r .* q;        @multiply by probs for previous choice situations: 1 by nrep@
        t=t+1;
     endo;
     p[n,1]=meanc(r');   @probability is average of r over all nrep draws@
     count=count+times[n,1];
     n=n+1;
endo;
retp(ln(p));
endp;

