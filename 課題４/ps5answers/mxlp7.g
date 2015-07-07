
@ Space allocation for program. Do not change. @
new , 30000;

@ Output to screen? (in addition to file) @
screen on;

@ Name of the output file, reset=overwrite existing file, on=add to it @
output file=output7.txt reset;

@ Put a title for your output in the quotes below. @
print "Mix logit.";
print ;

@ 1 to check inputs for conformability and consistency, else 0. @
VERBOSE = 1;

@ Number of people. (integer) @
NP = 361;

@ Number of observations. (integer) @
NOBS = 4308;

@ Maximium number of alternatives. (integer) @
NALT = 4;

@ Load or create XMAT (contain all of the explanatory variables and the@
@ censoring variable (if needed), YVEC (the dependent variable), @
@ and TIMES (giving the number of choice situations for each person.)@
@----------------------------------------------------------------@

load XMAT[NOBS,28] = xdata;
load YVEC[NOBS,1] = ydata;
load TIMES[NP,1] = times;

XMAT[.,21:28]=-XMAT[.,21:28];  @Reverse sign of TOD and seasonal@

@ Variables are now: price, contract length, LL, KK+KL, UL, TOD, seasonal.@

@----------------------------------------------------------------@


@ Number of variables in XMAT. (integer) @
NVAR = 7;

@ Give the number of explanatory variables that have fixed coefficients. @
@ (integer) @
NFC = 1;

@ NFCx1 vector to identify the variables in XMAT that have fixed @
@ coefficients. (column vector) @
IDFC = { 1 };

@ Give the number of explanatory variables that have normally @
@ distributed coefficients. (integer) @
NNC = 3;

@ NNCx1 vector to identify the variables in XMAT that have normally @
@ distributed coefficients. (column vector) @
IDNC = { 2, 3, 4  };

@ Give the umber of explanatory variables that have uniformly @
@ distributed coefficients @
NUC = 0;

@ NUCx1 vector to identify the variables in XMAT that have uniformly @
@ distributed coefficients. (column vector) @
IDUC = { 0 };

@ Give the number of explanatory variables that have triangularly @
@ distributed coefficients @
NTC = 0;

@ NTCx1 vector to identify the variables in XMAT that have triangularly @
@ distributed coefficients. (column vector) @
IDTC = { 0 };

@ Give the number of explanatory variables that have log-normally @
@ distributed coefficients. (integer) @
NLC = 2;

@ NLCx1 vector to identify the variables in XMAT that have @
@ log-normally distributed coefficients. (column vector) @
IDLC = { 6, 7 };

@ 1 if all people do not face all NALT alternatives, else 0. @
CENSOR = 0;

@ Identify the variable in XMAT that identifies the alternatives @
@ each person faces. (integer) @
IDCENSOR = 0; 

@ If you want to weight the observation, set DOWT to 1, else 0 @
DOWT = 0;

@ If DOWT=1, load or create an NPx1 vector of weights. @
WEIGHT=0;

@ 1 to print out the diagonal elements of the Hessian, else 0. @
PRTHESS = 0;

@ 1 to rescale any variable in XMAT, else 0. @
RESCALE = 0;

@ If RESCALE = 1 create a q x 2 matrix to id which variables to @
@ rescale and by what multiplicative factor, else make RESCLMAT @
@ a dummy value. @
RSCLMAT = { 0 };



@ Starting values for the parameters. @
@ (NFC+(2*NNC)+(2*NUC)+(2*NTC)+(2*NLC)) x 1 vector of starting values. @
@ Order is NFC fixed coefficients, followed by mean and standard deviation of each @
@ of NNC normal coefficients, followed by mean and standard deviation of each of NUC@
@ uniformly distributed coefficients, etc for the triangularly and log-normally @
@ distributed coefficients.@ 
@Take estimates from output.txt:@
B = {
      1.00000000	     -0.91209197	      0.02432014	
      2.00000000	      0.17162749	      0.00952860	
      3.00000000	     -0.21912153	      0.01543531	
      4.00000000	      0.37570394	      0.01674215	
      5.00000000	      2.16837941	      0.08376860	
      6.00000000	      1.39368451	      0.07477898	
      7.00000000	      1.49736944	      0.06631332	
      8.00000000	      0.95790589	      0.06122121	
      9.00000000	     -8.64229559	      0.21201288	
     10.00000000	      2.45200983	      0.10787261	
     11.00000000	     -8.92078655	      0.20182848	
     12.00000000	      1.35297490	      0.10041171	};
B=reshape(b,12,3);  @Reshape to be 3 columns as shown above.@
B=B[.,2];           @Keep second column, since those are the estimates.@
m=B[9 11,.];       @Estimated means of TOD and seasonal coefs.@
m=-m;               @Reverse the sign of these coefficient.@
s=B[10 12,.];       @Estimated standard deviations of these coefs.@
news=sqrt(ln((s./m).^2+1));  @Parameter s for lognormal with coef=exp(m+se)@
newm=ln(m)-(news.^2)./2;     @Parameter m for lognormal.@
B[9 11,.]=newm;
B[10 12,.]=news;
B=B[1,.]|B[3:12,.];   @Remove the stdv. for price coef, since this coef is fixed.@
 
@ 1 to constrain any parameter to its starting value, else 0. @
CZVAR = 0;

@ If CZVAR = 1, create a vector of zeros and ones of the same @
@ dimension as B identifying which parameters are to vary, else make @
@ BACTIVE = { 0 }. (column vector) @
BACTIVE = { 0 };

@ 1 to constrain any of the error components to equal each other, @
@ else 0. (integer) @
CEVAR = 0;

@ If CEVAR=1, create a matrix of ones and zeros to constrain the @
@ necessary random parameters to be equal, else make EQMAT=0. (matrix)@
EQMAT = { 0 };

@ Number of repetitions.  NREP must be >= 1. (integer) @
NREP = 100;

@ Choose random or halton draws. DRAWS=1 for random, 2 for Halton.@
DRAWS=1;

@ If DRAWS=1, set seed to use in random number generator. SEED1 must be >= 0. (integer) @
SEED1 = 46;

@ If DRAWS=2, specify the following.@
@ HALT=1 to create Halton draws, HALT=2 to use previously created Halton draws. @
HALT=1;

@ If HALT=1, set SAVH=1 if you want to save the Halton draws that are created; 0 otherwise. @ 
SAVH=0;

@ HMNAME = path and name for file of halton sequences. Be sure to put double \\ where@
@ single \ appears in the path. @
@ If HALT=1 and SAVH=1, the Halton draws that are created are saved to this file.@
@ If HALT=2, the Haton draws that were previously saved to this file are loaded.@
@ Note that, if HALT=2, the sequences must meet the specs of the current model,@
@ that is, the same NREP, NOBS, number of random coefficients, and distribution for each coefficient.@

HMNAME="c:\\temp2\\hm125.fmt";


@ Maximum number of iterations in the maximization. (integer) @
NITER = 100;

@ Tolerance for convergence. (small decimal) @
EPS = 1.e-4;

@ Identify the optimization routine: 1 Paul Ruud's routine     @
@                                    2 for Gauss's maxlik      @
OPTIM = 1;

@ Specify the optimization algorithm/hessian calculation.(integer)    @ 
@ Options with OPTIM=1: 1 for bhhh, 2 for numerical (newton-raphson)  @
@ Options with OPTIM=2: 1 for steepest descent, 2 for bfgs, 3 for dfp @
@     4 for numerical (newton-raphson), 5 for bhhh, 6 for prcg.       @
METHOD = 1;

@ 1 if OPTIM=1 and want to use modified iteration procedure; else 0. @
MNR = 1;

@ If OPTIM=1, set STEP to the step length the maximization routine @
@ should initially try. @
STEP = 1;

@ If OPTIM=1, then set ROBUST=1 if you want robust standard errors, or@
@ ROBUST=0 if you want regular standard errors. With OPTIM=2, this option doesn't exist.@
ROBUST=1;


@======================================================================@
@@@	You should not need to change anything below this line	     @@@
@======================================================================@
@ Create global for the number of estimated variables @
NEVAR = NFC+(NNC+NUC+NTC+NLC)*2;

@ Check inputs if VERBOSE=1 @
if ((VERBOSE /= 1) and (VERBOSE /= 0));
  print "VERBOSE must 0 or 1.";
  print "Program terminated.";
  stop;
endif;
if VERBOSE;
  pcheck;
else;
  print "The inputs have not been checked since VERBOSE=0.";
  print;
endif;

@ Rescale the variables. @
if RESCALE;
  j = rows(RSCLMAT);
  i = 1;
  if VERBOSE;
    if (RSCLMAT[.,1] > NVAR);
      print "RSCLMAT identifies a variable that is not in the data set.";
      print "Program terminated.";
      stop;
    endif;
    print "Rescaling Data:";
    print "        Variable      Mult. Factor";
    do while i <= j;
      RSCLMAT[i,1] RSCLMAT[i,2];
      XMAT[.,(RSCLMAT[i,1]-1)*NALT+1:RSCLMAT[i,1]*NALT] =
      XMAT[.,(RSCLMAT[i,1]-1)*NALT+1:RSCLMAT[i,1]*NALT] * RSCLMAT[i,2];
      i = i + 1;
    endo;
    print " ";
  else;
    do while i <= j;
      XMAT[.,(RSCLMAT[i,1]-1)*NALT+1:RSCLMAT[i,1]*NALT] =
      XMAT[.,(RSCLMAT[i,1]-1)*NALT+1:RSCLMAT[i,1]*NALT] * RSCLMAT[i,2];
      i = i + 1;
    endo;
  endif;
endif;

@ Print out starting values if VERBOSE = 1. @
if VERBOSE;
  print "There are " NP " respondents and " NOBS " observations.";
  print "The model has" NFC " fixed coefficients, for variables" IDFC;
  print "          and" NNC " normally distributed coefficients, for variables" IDNC;
  print "          and" NUC " uniformly distributed coefficients, for variables" IDUC;
  print "          and" NTC " triangularly distributed coefficients, for variables" IDTC;
  print "          and" NLC " log-normally distributed coefficients, for variables" IDLC;
  print;
  if CZVAR;
    print "Starting values:" ;
    print B;
    print ;
    print "Parameters that are estimated (1) or held at starting value (0):";
    print BACTIVE;
    print ;
  endif;
  if (CZVAR == 0);
    print "Starting values:";
    print B;
    print;
    print "All parameters are estimated; none is held at its starting value.";
    print;
  endif;
endif;

@ Create new B and BACTIVE with reduced lengths if @
@ user specifies equality constraints. @
if CEVAR;
  if CZVAR;
    BACTIVE = EQMAT * BACTIVE;
    BACTIVE = BACTIVE .> 0;
  endif;
  B = (EQMAT * B) ./ (EQMAT * ones((NFC+2*NNC+2*NUC+2*NTC+2*NLC),1));
  if VERBOSE and CZVAR;
    print "Some parameters are constrained to be the same.";
    print "Starting values of constrained parameters:";
    print B;
    print ;
    print "Constrained parameters that are estimated (1) or held at starting value (0):";
    print BACTIVE;
    print;
  endif;
  if VERBOSE and (CZVAR == 0);
    print "Some parameters are constrained to be the same.";
    print "Starting values of constrained parameters:";
    print B;
    print;
    print "All constrained parameters are estimated; none is held at its starting value.";
    print;
  endif;
endif;

@ Describing random terms. @
if VERBOSE;
  if DRAWS == 1; 
    print "Random draws are used."; 
    print "Random error terms are based on:";
    print "Seed:  " SEED1;
    print;
  elseif DRAWS == 2;
    print "Halton draws are used.";
    print; 
  else;
    print "DRAWS must be 1 or 2. Program terminated.";
    stop;
  endif;
  print "Repetitions:  " NREP;
endif;

/* Number of random coefficients or 1, whichever is higher. */
NECOL = maxc( ones(1,1) | (NNC+NUC+NTC+NLC) );

if DRAWS == 2;
   /* CREATE OR LOAD HALTON SEQUENCES. */

   if HALT == 2; 
     loadm hm = ^HMNAME;
     print "Loaded Halton sequences.";
   elseif HALT == 1;

       @ Create the Halton sequence @

       print "Creating Halton sequences ....";


        /* Provide prime number vector */

       prim = { 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71
                    73 79 83 89 97 101 103 107 109 113 };
       print "Halton sequences are based in primes: " prim[1,1:NECOL];
       print;

      /* Develop a halton matrix (hm) of size nrep x (nobs*necol); The first 'nobs'
      columns provide halton numbers for first dimension of integration,
      the second 'nobs' columns provide the halton numbers for the second
      dimension, and so on; cdfinvn is the inverse cumulative standard normal
      distribution function; PROC halton creates sequence; PROC cdfinvn takes
      inverse normal: windows version of gauss has this as a command. For
      non-normal distributions, use inverse of other distribution. */

      h = 1;
      hm = {};
      do while h <= (NECOL);
          hm1 = halton(10+nrep*np,prim[h]);
          if h <= NNC or h > (NNC+NUC+NTC);  @ Normal and lognormal distributions. @
                   @ If there are no random coefs, st NECOL=1 while NNC=NUC=NTC=NLC=0, @
                   @ then, hm1 will be treated as normally distributed.@
                hm1 = cdfinvn(hm1);
                @ The inverse-normal proc produces very extreme values sometimes. This truncates.@
                 hm1=hm1.*(hm1 .le 10) + 10 .* (hm1 .gt 10);
                 hm1=hm1.*(hm1 .ge -10) -10 .* (hm1 .lt -10);
          endif;
          if h > NNC and h <= (NNC+NUC);  @Uniform distribution.@
                 hm1=hm1.*2 - 1;  
          endif;
          if h > (NNC+NUC) and h <= (NNC+NUC+NTC); @Triangular distribution.@
                 hm1= (sqrt(2.*hm1)-1).*(hm1 .<= 0.5) + (1-sqrt(2.*(1-hm1))) .* (hm1 .> 0.5); 
          endif;
          hm = hm~hm1[11:rows(hm1),1];
          h=h+1;
     endo;

     print "Finished Halton sequences.";

     if SAVH; 
         save ^HMNAME = hm; 
         print "Saved Halton sequences.";
     endif;

   else;
      print "HALT must equal 1 or 2. Job terminated.";
      stop;

   endif;

  print "Number of rows in Halton matrix: " rows(hm);
  print "Number of columns in Halton matrix: " cols(hm);
endif;

@ END OF HALTON DRAWS @

@ IDA is a vector that identifies the variables with normal, uniform or triangular coefficients.@
@ It is used in LL, gradient and forecst procs. @
  IDA={0};
  if NNC>0; IDA=IDNC;  endif;
  if NNC==0 and NUC>0; IDA=IDUC; endif;
  if NNC>0 and NUC>0; IDA=IDA|IDUC; endif;
  if (NNC+NUC)==0 and NTC>0; IDA=IDTC; endif; 
  if (NNC+NUC)>0 and NTC>0; IDA=IDA|IDTC; endif;  


@ Create dependent variable permutation matrix for the gradient @
YPERM=zeros(NOBS,NALT);
i = 1;
do while i<=NOBS;
  YPERM[i,YVEC[i,1]] = 1;
  i = i + 1;
endo;

@ Initialize the STEP to twice its value for Paul Ruud's routine. @
if (OPTIM==1);
  STEP = STEP*2;
endif;

@ Set up and do maximization @
if OPTIM == 1;
  beta = domax(&ll,&gr,B,BACTIVE);
  print;
  print "Remember: Signs of standard deviations are irrelevant.";
  print "Interpret them as being positive.";
  print;
endif;

if OPTIM == 2;
  library maxlik,pgraph;
  #include maxlik.ext;
  maxset;
  _max_GradTol = EPS;
  _max_GradProc = &gr;
  _max_MaxIters = NITER;
  _max_Algorithm = METHOD;
  if DOWT;
    __weight = WEIGHT;
  endif;
  if CZVAR;
    _max_Active = BACTIVE;
  endif;
  {beta,f,g,cov,ret} = maxlik(XMAT,0,&ll,B);
  call maxprt(beta,f,g,cov,ret);
  print;
  print "Remember: Signs of standard deviations are irrelevant.";
  print "Interpret them as being positive.";
  print;
  if (CZVAR == 0);
    print "gradient(hessian-inverse)gradient is:" ((g/_max_FinalHess)'g);
  else;
    g = selif(g,BACTIVE);
    print "gradient(hessian-inverse)gradient is:" ((g/_max_FinalHess)'g);
  endif;
  if PRTHESS;
    print "diagonal of hessian:" ((diag(_max_FinalHess))');
    print;
  endif;
endif; 


@ THIS IS THE END OF THE MAIN PROGRAM. @
@ PROCS ll, gr, gpnr, expand, domax, pcheck follow.@

/* LOG-LIKELIHOOD FUNCTION */
proc ll(b,x);

  @ Relies on the globals: NALT, NOBS, NP, NREP, NECOL, SEED1, CENSOR @
  @                        NFC, IDFC, NNC, NUC,NTC, IDA, NLC, IDLC @
  @                        CZVAR, BACTIVE, CEVAR, EQMAT, XMAT, DRAWS @

  local c, k, n, t, km, kmm, rd, seed2;
  local v, ev, p0, p00, err, mm;


  if CEVAR;
    b = EQMAT' * b;            @ Expand b to its original size. @
  endif;

  v = zeros(NOBS,NALT);         @ Argument to logit formula    @

  p0 = zeros(NP,1);             @ Simulated probability @          
  if CENSOR;
    c = (IDCENSOR-1)*NALT;	@ Location of censor variable	@
  endif;

  k = 1;
  do while k <= NFC;            @ Adds variables with fixed coefficients @
    km = (IDFC[k,1]-1)*NALT;
    v = v + b[k] .* XMAT[.,(km+1):(km+NALT)];
    k = k+1;
  endo;

  seed2 = SEED1;
  rndseed seed2;

  rd = 0;
  n = 1;
  do while n <= NP;
    if DRAWS == 1;
        err  = rndn(NREP,NECOL);   
         if NUC > 0;
                 err[.,(NNC+1):(NNC+NUC)] = (rndu(NREP,NUC) .* 2) -1;
        endif;                      
         if NTC > 0;
                mm = rndu(NREP,NTC) ;
                err[.,(NNC+NUC+1):(NNC+NUC+NTC)] = (sqrt(2.*mm)-1).*(mm .<= 0.5) 
                                                   + (1-sqrt(2.*(1-mm))) .* (mm .> 0.5); 
          endif;
     endif;
    if DRAWS == 2;
        err=hm[(NREP*(n-1)+1):(NREP*(n-1)+NREP),.] ;
    endif;
 @ err has NREP rows and NECOL columns for each person. @
  
    p00 = ones(NREP,1);
    t=1;
    do while (t<=TIMES[n]);
      kmm = rd + t;
      ev = v[kmm,.];
      k = 1;
      do while k <= NNC+NUC+NTC;        @ Adds variables with normal, uniform and tringular coefficients @
        km = (IDA[k,1]-1)*NALT;
        ev = ev + (b[NFC+(2*k)-1] + (b[NFC+(2*k)] .* err[.,k]))
              .* XMAT[kmm,(km+1):(km+NALT)];
        k = k+1;
      endo;
      k = 1;
      do while k <= NLC;        @ Adds variables with log-normal coefficients @
        km = (IDLC[k,1]-1)*NALT;
        ev = ev + exp(b[NFC+(2*(NNC+NUC+NTC))+(2*k)-1] 
                       + (b[NFC+(2*(NNC+NUC+NTC))+(2*k)] .* err[.,(NNC+NUC+NTC+k)]))
                       .* XMAT[kmm,(km+1):(km+NALT)];
        k = k+1;
      endo;
      ev = exp(ev);
      if CENSOR;
        p00 = p00.*ev[.,YVEC[kmm,1]]./sumc((ev .* XMAT[kmm,(c+1):(c+NALT)])');
      else;
        p00 = p00.*ev[.,YVEC[kmm,1]]./(sumc(ev'));
      endif;
      t = t+1;
    endo;
    rd = rd + TIMES[n];
    p0[n,1] = meanc(p00);
    n = n + 1;
  endo;
  retp(ln(p0));
endp;

/* GRADIENT PROCEDURE */
proc gr(b,x);

  @ Relies on the globals: NALT, NOBS, NP, NREP, NECOL, SEED1, CENSOR @
  @                        NFC, IDFC, NNC, NUC, NTC, IDA, NLC, IDLC            @
  @                        CZVAR, BACTIVE, CEVAR, EQMAT, XMAT, YPERM, DRAWS  @

  local c, g, k, n, t, km, kmm, rd, seed2, y;
  local denom, der, v, ev, p0, p00, p1, err, mm;

  if CEVAR;
    b = EQMAT' * b;            @ Expand b to its original size. @
  endif;

  if CENSOR;
   c = (IDCENSOR-1)*NALT;      @ Location of censor variable    @
  endif;

  v = zeros(NOBS,NALT);        @ Argument to logit formula      @
  p0  = zeros(NP,1);           @ Simulated probability          @
  der = zeros(NP,NEVAR);       @ Jacobian matrix                @

  k = 1;
  do while k <= NFC;            @ Adds variables with fixed coefficients @
    km = (IDFC[k,1]-1)*NALT;
    v = v + b[k] .* XMAT[.,(km+1):(km+NALT)];
    k = k+1;
  endo;

  seed2 = SEED1;
  rndseed seed2;

  rd = 0;
  n = 1;
  do while n <= NP;

   if DRAWS == 1;
        err  = rndn(NREP,NECOL);   
         if NUC > 0;
                 err[.,(NNC+1):(NNC+NUC)] = (rndu(NREP,NUC) .* 2) -1;
        endif;                      
         if NTC > 0;
                mm = rndu(NREP,NTC) ;
                err[.,(NNC+NUC+1):(NNC+NUC+NTC)] = (sqrt(2.*mm)-1).*(mm .<= 0.5) 
                                                   + (1-sqrt(2.*(1-mm))) .* (mm .> 0.5); 
          endif;
     endif;
     if DRAWS == 2;
        err=hm[(NREP*(n-1)+1):(NREP*(n-1)+NREP),.] ;
    endif;
 @ err has NREP rows and NECOL columns for each person. @

    p00 = ones(NREP,1);
      g = zeros(NREP,NEVAR);

    t=1;
    do while (t<=TIMES[n]);
      kmm = rd + t;
      ev = v[kmm,.];
      k = 1;
      do while k <= NNC+NUC+NTC;        @ Adds variables with normal,uniform, and triangular coefficients @
        km = (IDA[k,1]-1)*NALT;
        ev = ev + (b[NFC+(2*k)-1] + (b[NFC+(2*k)] .* err[.,k]))
              .* XMAT[kmm,(km+1):(km+NALT)];
        k = k+1;
      endo;
      k = 1;
      do while k <= NLC;        @ Adds variables with log-normal coefficients @
        km = (IDLC[k,1]-1)*NALT;
        ev = ev + exp(b[NFC+(2*(NNC+NUC+NTC))+(2*k)-1] 
                 + (b[NFC+(2*(NNC+NUC+NTC))+(2*k)] .* err[.,(NNC+NUC+NTC+k)]))
                       .* XMAT[kmm,(km+1):(km+NALT)];
        k = k+1;
      endo;


      ev = exp(ev);
      if CENSOR;
        denom = sumc((ev .* XMAT[kmm,(c+1):(c+NALT)])');
        p00   = p00 .* ev[.,YVEC[kmm,1]]./denom;
        p1    = (ev.*XMAT[kmm,(c+1):(c+NALT)])./denom;
      else;
        denom = sumc(ev');
        p00   = p00 .* ev[.,YVEC[kmm,1]]./denom;
        p1    = ev./denom;
      endif;

      y = YPERM[kmm,.]-p1;

      k = 1;
      do while k<=NFC;
        km = (IDFC[k,1]-1)*NALT;
        g[.,k] = g[.,k] + sumc((XMAT[kmm,km+1:km+NALT].*y)');
        k = k + 1;
      endo;

      k = 1;
      do while k<=NNC+NUC+NTC;
        km = (IDA[k,1]-1)*NALT;
        g[.,NFC+(2*k)-1] = g[.,NFC+(2*k)-1] +
                           sumc((XMAT[kmm,km+1:km+NALT].*y)');
        g[.,NFC+(2*k)]   = g[.,NFC+(2*k)] +
                           sumc((err[.,k].*XMAT[kmm,km+1:km+NALT].*y)');
        k = k + 1;
      endo;

      k = 1;
      do while k<=NLC;
        km = (IDLC[k,1]-1)*NALT;
        g[.,NFC+2*(NNC+NUC+NTC)+(2*k)-1] = g[.,NFC+2*(NNC+NUC+NTC)+(2*k)-1] + 
                               sumc((XMAT[kmm,km+1:km+NALT].*y)');
        g[.,NFC+2*(NNC+NUC+NTC)+(2*k)] = g[.,NFC+2*(NNC+NUC+NTC)+(2*k)] +
                              sumc((err[.,NNC+NUC+NTC+k].*XMAT[kmm,km+1:km+NALT].*y)');
        k = k + 1;
      endo; 

      t = t+1;
    endo;

    km = NFC+2*(NNC+NUC+NTC);   @ multiply correction term for log-normals @
    k = 1;
    do while k<=NLC;
      g[.,km+(2*k)-1:km+(2*k)] = g[.,km+(2*k)-1:km+(2*k)] .*
                     exp(b[km+(2*k)-1,1]+b[km+(2*k),1].*err[.,NNC+NUC+NTC+k]);
      k = k + 1;
    endo;
    p0[n,1] = meanc(p00);
    der[n,.] = (meanc(p00.*g))';
    rd = rd + TIMES[n];
    n = n + 1;
  endo;
  if CEVAR;
    der = (der./p0) * EQMAT';
  else;
    der = der./p0;
  endif;
  retp(der);
endp;

/* GRADIENT FOR PAUL RUUD'S ROUTINE WHEN USING NEWTON-RAPHSON*/
/* USE WHEN OPTIM == 1 AND METHOD == 2 */
proc gpnr(b);
  @ Relies on global: XMAT  @
  local grad;

  if DOWT;
    grad = WEIGHT .* gr(b,XMAT);
  else;
    grad = gr(b,XMAT);
  endif;

  retp(sumc(grad));
endp;

/* EXPANDS THE DIRECTION VECTOR; ALLOWS PARAMETERS TO STAY AT STARTING	*/
/* VALUES; HELPER PROCEDURE FOR &domax					*/
proc expand( x, e );
    local i,j;
    i = 0;
    j = 0;
    do while i < rows(e);
        i = i + 1;
        if e[i];
            j = j + 1;
            e[i] = x[j];
        endif;
    endo;
    if j/=rows(x); "Error in expand."; stop; endif;
    retp( e );
endp;

/* MAXIMIZATION ROUTINE COURTESY OF PAUL RUUD */
proc domax( &f, &g, b, bactive );

  @ Relies on the globals: CZVAR, EPS, METHOD, NITER, NOBS,  @
  @                        PRTHESS, XMAT, NP, NEVAR          @

  local f:proc, g:proc;
  local direc, first, grad, sgrad, hesh, ihesh, lambda;
  local nb, printer, repeat, step1, wtsq;
  local _biter, _f0, _f1, _fold,  _tol;

  _tol  = 1;
  _biter = 0;
  nb = seqa(1,1,NEVAR);

  _f0 = f( b, XMAT );
  if DOWT;
    _f0 = sumc(WEIGHT.*_f0);
    wtsq = WEIGHT .^ (.5);
  else;
    _f0 = sumc(_f0);
  endif;

  format /m1 /rdt 16,8;
  print; print; print;

  do while (_tol > EPS or _tol < 0) and (_biter < NITER);
    _biter = _biter + 1;

    print "==========================================================================";
    print "          Iteration: " _biter;
    print "          Function:  " _f0;

    grad = g( b, XMAT );
    if (METHOD == 1);
      if DOWT;
        grad = wtsq.*grad;
        hesh = grad'grad;
        grad = wtsq.*grad;
      else;
        hesh = grad'grad;
      endif;     
    else;
      if DOWT;
        grad = WEIGHT .* grad;
      endif;
      hesh = -gradp( &gpnr, b );   @ WEIGHT done in &gpnr @
    endif;
    sgrad = sumc(grad);

    @ Select only the variables that we want to maximize over @
    if CZVAR; 
      sgrad  = selif( sgrad, bactive );
      hesh  = selif( hesh, bactive );
      hesh  = selif( hesh', bactive );
    endif;

    if (det(hesh)==0);
      print "Singular Hessian!";
      print "Program terminated.";
      stop;
    else;
      ihesh = inv(hesh);
      direc = ihesh * sgrad;
    endif;

    _tol   = direc'sgrad;

    if CZVAR;
      direc = expand( direc, bactive);
    endif;

    print "          Tolerance: " _tol;
    print "--------------------------------------------------------------------------";

    if PRTHESS;
      if CEVAR and CZVAR;
        printer = expand(sgrad./NP,bactive)~expand(diag(hesh),bactive);
        printer = nb~EQMAT'*b~EQMAT'*printer[.,1]~EQMAT'printer[.,2];
      elseif CEVAR;
        printer = nb~EQMAT'*b~(EQMAT'*sgrad./NP)~(EQMAT'*diag(hesh));
      elseif CZVAR;
        printer = nb~b~expand(sgrad./NP,bactive)~expand(diag(hesh),bactive);
      else;
        printer = nb~b~(sgrad./NP)~(diag(hesh));
      endif;

      print "                             Coefficients             Rel. Grad.               Hessian";

    else;

      if CEVAR and CZVAR;
        printer = expand(sgrad./NP,bactive);
        printer = nb~EQMAT'*b~EQMAT'*printer[.,1];
      elseif CEVAR;
        printer = nb~EQMAT'*b~(EQMAT'*sgrad./NP);
      elseif CZVAR;
        printer = nb~b~expand(sgrad./NP,bactive);
      else;
        printer = nb~b~(sgrad./NP);
      endif;

      print "                             Coefficients             Rel. Grad.";

    endif;
    print printer;

    if (_tol >= 0) and (_tol < 1.e-6);
      break;
    elseif _tol < 0;
      direc = -direc;
    endif;

    step1 = STEP;
    lambda = .5;
    repeat = 1;
    first = 1;
    _f1 = _f0;
    steploop:
      step1 = step1 * lambda;
      _fold = _f1;
      if DOWT;
        _f1 = sumc(WEIGHT .* f(b+step1*direc,XMAT));
      else;
        _f1 = sumc( f( b+step1*direc, XMAT ) );
      endif;
    print "--------------------------------------------------------------------------";
      print " Step: " step1;
      print " Function: " _f1;
      if repeat;
        print " Change: " _f1-_f0;
      else;
        print " Change: " _f1-_fold;
      endif;
      if MNR;
        if (step1 < 1.e-5);
          print "Failed to find increase.";
          retp(b);
        elseif (_f1 <= _f0) and (repeat);
          first = 0;
          goto steploop;
        elseif (_f1 > _fold) and (first);
          lambda = 2;
          repeat = 0;
          goto steploop;
        endif;
      else;
        if (step1 < 1.e-5);
          print "Failed to find increase.";
          retp(b);
        elseif (_f1 <= _f0);
          goto steploop;
        endif;
      endif;
      
      if (repeat);
        b = b + step1*direc;
        _f0 = _f1;
      else;
        b = b + .5 * step1 * direc;
        _f0 = _fold;
      endif;

  endo;

  print "==========================================================================";
  print;

  format /m1 /rdt 1,8;
  if (_tol< EPS);
    print "Converged with tolerance:  " _tol;
    print "Function value:  " _f0;
  else;
    print "Stopped with tolerance:  " _tol;
    print "Function value:  " _f1;
  endif;

  print;
  lambda = eig(hesh);
  if lambda>0;
    print "Function is concave at stopping point.";
  else;
    print "WARNING:  Function is not concave at stopping point.";
  endif;
  print;

  if ROBUST == 0 and DOWT == 1; @ Create Hessian and gradient for regular @
                            @ standard errors when have weights. @
    if CZVAR;
      grad = grad'grad;
      grad = selif(grad, BACTIVE);
      grad = selif(grad', BACTIVE);
      ihesh = ihesh*(grad)*ihesh;
    else;
      ihesh = ihesh*(grad'grad)*ihesh;
    endif;
  endif;

  if ROBUST == 1;   @Create gradient and hessian for robust standard errors. @
    
    if METHOD == 1;
      hesh  = - gradp( &gpnr, b ); 
   
      if CZVAR; 
           grad  = selif( grad', bactive )';
           hesh  = selif( hesh, bactive );
           hesh  = selif( hesh', bactive );
       endif;
   
     endif;

     ihesh=inv(hesh);
     ihesh=ihesh*(grad'grad)*ihesh;
     

  print "Uses robust standard errors.";
  else;
  print "Uses non-robust standard errors.";
  endif;





  if CEVAR and CZVAR;
    printer = expand(sqrt(diag(ihesh)), BACTIVE);
    printer = nb~EQMAT'*b~EQMAT'*printer;
  elseif CEVAR;
    printer = nb~EQMAT'*b~(EQMAT'*sqrt(diag(ihesh)));
  elseif CZVAR;
    printer = nb~b~expand(sqrt(diag(ihesh)),BACTIVE);
  else;
    printer = nb~b~sqrt((diag(ihesh)));
  endif;

  format /m1 /rdt 16,8;
  print "      Parameters               Estimates           Standard Errors";
  print "--------------------------------------------------------------------------";
  print printer;
  retp( b );
endp;

/* This proc checks the inputs if VERBOSE=1 */
proc (0) = pcheck;
  local i,j;

  @ Checking XMAT @
  if (rows(XMAT) /= NOBS);
    print "XMAT has" rows(XMAT) "rows";
    print "but it should have NOBS="  NOBS   "rows.";
    print "Program terminated.";
    stop;
  elseif(cols(XMAT) /= (NVAR*NALT));
    print "XMAT has" cols(XMAT) "columns";
    print "but it should have NVAR*NALT= " (NVAR*NALT) "columns.";
    print "Program terminated.";
    stop;
  else;
    print "XMAT has:";
    print "Rows:  " NOBS;
    print "Cols:  " NVAR*NALT ;
    print "Containing" NVAR "variables for " NALT " alternatives.";
    print;
  endif;

  @ Check dependent variable @
  if (rows(YVEC) /= NOBS);
    print "YVEC has" rows(YVEC) "rows";
    print "but it should have NOBS="  NOBS   "rows.";
    print "Program terminated.";
    stop;
  endif;
  if (cols(YVEC) /= 1);
    print "YVEC should have only one column.";
    print "Program terminated.";
    stop;
  endif;

  @ Check TIMES @
  if (rows(TIMES) /= NP);
    print "TIMES has" rows(TIMES) "rows";
    print "but it should have NP="  NP   "rows.";
    print "Program terminated.";
    stop;
  endif;
  if (cols(TIMES) /= 1);
    print "TIMES should have only one column.";
    print "Program terminated.";
    stop;
  endif;
  if (sumc(TIMES) /= NOBS);
    print "sumc of TIMES =" sumc(TIMES) "but it should equal NOBS.";
    print "Program terminated.";
    stop;
  endif; 

  @ Check WEIGHT @
  if (DOWT /=0) and (DOWT /=1);
    print "DOWT must be 0 or 1.";
    print "Program terminated.";
    stop;
  endif;
  if DOWT;
    if (rows(WEIGHT) /= NP);
      print "WEIGHT has" rows(WEIGHT) "rows";
      print "but it should have NP="  NP   "rows.";
      print "Program terminated.";
      stop;
    endif;
    if (cols(WEIGHT) /= 1);
      print "WEIGHT should have only one column.";
      print "Program terminated.";
      stop;
    endif;
  endif;

  @ Checking fixed coefficients @
  if (NFC /= 0);
    if (rows(IDFC) /= NFC);
      print "IDFC has" rows(IDFC) "rows when it should have NFC=" NFC "rows.";
      print "Program terminated.";
      stop;
    endif;
    if (cols(IDFC) /= 1);
      print "Commas are needed between the elements of IDFC.";
      print "Program terminated.";
      stop;
    endif;
    if (sumc(IDFC.>NVAR)>0);
      print "IDFC identifies a variable that is not in the data set.";
      print "All elements of IDFC should be <= NVAR, which is " NVAR;
      print "Program terminated.";
      stop;
    endif;
  endif;

  @ Checking normal coefficients @ 
  if (NNC /= 0);
    if (rows(IDNC) /= NNC);
      print "IDNC has" rows(IDNC) "rows when it should have NNC=" NNC "rows.";
      print "Program terminated.";
      stop;
    endif;
    if (cols(IDNC) /= 1);
      print "Commas are needed between the elements of IDNC.";
      print "Program terminated.";
      stop;
    endif;
    if (sumc(IDNC.>NVAR)>0);
      print "IDNC identifies a variable that is not in the data set.";
      print "All elements of IDNC should be <= NVAR, which is " NVAR;
      print "Program terminated.";
      stop;
    endif;
  endif;

  @ Check uniformly distributed coefficients @
  if (NUC /= 0);
    if (rows(IDUC) /= NUC);
      print "IDUC has" rows(IDUC) "rows when it should have NUC=" NUC "rows.";
      print "Program terminated.";
      stop;
    endif;
    if (cols(IDUC) /= 1);
      print "Commas are needed between the elements of IDUC.";
      print "Program terminated.";
      stop;
    endif;
    if (1-(IDUC <= NVAR));
      print "IDUC identifies a variable that is not in the data set.";
      print "All elements of IDUC should be <= NVAR, which is " NVAR;
      print "Program terminated.";
      stop;
    endif;
  endif;

  @ Check traingularly distributed coefficients @
  if (NTC /= 0);
    if (rows(IDTC) /= NTC);
      print "IDTC has" rows(IDTC) "rows when it should have NTC=" NTC "rows.";
      print "Program terminated.";
      stop;
    endif;
    if (cols(IDTC) /= 1);
      print "Commas are needed between the elements of IDTC.";
      print "Program terminated.";
      stop;
    endif;
    if (1-(IDTC <= NVAR));
      print "IDTC identifies a variable that is not in the data set.";
      print "All elements of IDTC should be <= NVAR, which is " NVAR;
      print "Program terminated.";
      stop;
    endif;
  endif;

  @ Checking log-normal coefficients @ 
  if (NLC /= 0);
    if (rows(IDLC) /= NLC);
      print "IDLC has" rows(IDLC) "rows when it should have NLC=" NLC "rows.";
      print "Program terminated.";
      stop;
    endif;
    if (cols(IDLC) /= 1);
      print "Commas are needed between the elements of IDLC.";
      print "Program terminated.";
      stop;
    endif;
    if (sumc(IDLC.>NVAR)>0);
      print "IDLC identifies a variable that is not in the data set.";
      print "All elements of IDLC should be <= NVAR, which is " NVAR;
      print "Program terminated.";
      stop;
    endif;
  endif;

  @ Check CENSOR @
  if ((CENSOR /= 1) and (CENSOR /= 0));
    print "CENSOR must be 0 or 1.";
    print "Program terminated.";
    stop;
  endif;
  if CENSOR;
    if IDCENSOR > NVAR;
      print "The censoring variable cannot be located";
      print "since you set CENSOR larger than NVAR.";
      print "Program terminated.";
      stop;
    endif;
    i = (IDCENSOR-1)*NALT;
    j = 1;
    do while j<=NOBS;
      if (XMAT[j,i+YVEC[j,1]]==0);
        print "Your censoring variable eliminates the chosen alternative";
        print "for observation " j;
        print "Program terminated.";
        stop;
      endif;
      j = j + 1;
    endo;
  endif;

  @ Check PRTHESS and RESCALE @
  if ((PRTHESS /= 1) and (PRTHESS /= 0));
    print "PRTHESS must be 0 or 1.";
    print "Program terminated.";
    stop;
  endif;
  if ((RESCALE /= 1) and (RESCALE /= 0));
    print "RESCALE must be 0 or 1.";
    print "Program terminated.";
    stop;
  endif;

  @ Check B @
  if (rows(B) /= NEVAR);
    print "Starting values B has " rows(B) "rows";
    print "when it should have NFC+2*NNC+2*NUC+2*NTC+2*NLC= " NEVAR "rows.";
    print "Program terminated.";
    stop;
  endif;
  if (cols(B) /= 1);
    print "Commas needed between the elements of B.";
    print "Program terminated.";
    stop;
  endif;

  @ Check CZVAR @
  if ((CZVAR /= 1) and (CZVAR /= 0));
    print "CZVAR must be 0 or 1.";
    print "Program terminated.";
    stop;
  endif;
  if CZVAR;
    if (rows(BACTIVE) /= NEVAR);
      print "BACTIVE has " rows(BACTIVE) "rows";
      print "when it should have NFC+2*NNC+2*NUC+2*NTC+2*NLC= " NEVAR "rows.";
      print "Program terminated.";
      stop;
    endif;
    if (cols(BACTIVE) /= 1);
      print "Commas needed between the elements of BACTIVE.";
      print "Program terminated.";
      stop;
    endif;
  endif;

  @ Check CEVAR @
  if ((CEVAR /= 1) and (CEVAR /= 0));
    print "CEVAR must be 0 or 1.";
    print "Program terminated.";
    stop;
  endif;
  if CEVAR;
    if (cols(EQMAT) /= NEVAR);
      print "EQMAT has " cols(EQMAT) " columns";
      print "when it should have NFC+2*NNC+2*NUC+2*NTC+2*NLC=" NEVAR " columns.";
      print "Program terminated.";
      stop;
    endif;
    if (rows(EQMAT)>=NEVAR);
      print "EQMAT has " rows(EQMAT) " rows";
      print "when it should have strictly less than NFC+2*NNC+2*NUC+2*NTC+2*NLC=" NEVAR;
      print "rows.";
      print "Program terminated.";
      stop;
    endif;
  endif;

  @ Checking NREP @
  if (NREP <= 0);
    print "Error in NREP:  must be positive.";
    print "Program terminated.";
    stop;
  endif;

  @ Check SEED1 @
  if (SEED1<=0);
    print "SEED1 =" SEED1 "must be a positive integer.";
    print "Program terminated.";
    stop;
  endif;

  @ Check METHOD and OPTIM @
  if (METHOD < 1);
    print "METHOD must be 1-6.";
    print "Program terminated.";
    stop;
  endif;
  if (OPTIM /= 1) and (OPTIM /= 2);
    print "OPTIM must be 1 or 2.";
    print "Program terminated.";
    stop;
  endif;
  if ((OPTIM == 1) and (METHOD > 2));
    print "Method "  METHOD " is not an option with OPTIM = 1.";
    print "Program terminted.";
    stop;
  endif;
  if ((OPTIM == 2) and (METHOD > 6));
    print "Method " METHOD " is not an option with OPTIM = 2.";
    print "Program terminated.";
    stop;
  endif;

  @ Check MNR @
  if ((MNR /= 1) and (MNR /= 0));
    print "MNR must be 0 or 1.";
    print "Program terminated.";
    stop;
  endif;

  @ Check STEP @
  if (STEP<=0);
    print "STEP must be greater than zero.";
    print "Program terminated.";
    stop;
  endif;

  @ Check ROBUST @
  if ((ROBUST /= 1) and (ROBUST /= 0));
    print "ROBUST must be 0 or 1.";
    print "Program terminated.";
    stop;
  endif;

  @ Check DRAWS @
  if ((DRAWS /= 1) and (DRAWS /= 2));
    print "DRAWS must be 1 or 2.";
    print "Program terminated.";
    stop;
  endif;

  @ Check HALT @
  if ((HALT /= 1) and (HALT /= 2));
    print "HALT must be 1 or 2.";
    print "Program terminated.";
    stop;
  endif;

  print "The inputs pass all the checks and seem fine.";
  print;
  retp;
endp;


/* Halton procedure */

/*  Proc to create Halton sequences using the pattern described in Train, "Halton Sequences
for Mixed Logit." The integer n is the length of the Halton sequence that is required, and 
s is the prime that is used in creating the sequence. 

Given the length of the sequence n, the integer k is determined such that s^k<n<s^k+1. That is,
a sequence using s^1 up to s^k is too short, and a sequence using s^1 up to s^(k+1) is too long. 
Using this fact, the proc is divided in two parts to save time and space. 
The first part creates the sequence for s^1 up to s^k. The second
part creates only as much as needed of the additional sequence using s^(k+1). */

proc halton(n,s);
local phi,i,j,y,x,k;
k=floor(ln(n+1) ./ ln(s));    @We create n+1 Halton numbers including the initial zero.@
phi={0};
i=1;
do while i .le k;  
  x=phi;
   j=1;
  do while j .lt s;
     y=phi+(j/s^i);
     x=x|y;
     j=j+1;
  endo;
  phi=x;
  i=i+1;
endo;
 
x=phi;
 j=1;
do while j .lt s .and rows(x) .lt (n+1);  
   y=phi+(j/s^i);
   x=x|y;
   j=j+1;
 endo;

phi=x[2:(n+1),1];  @Starting at the second element gets rid of the initial zero.@
retp(phi);
endp;




/* For the DOS version of Gauss, here is the CDFINVN
   procedure, which is incorporated directly
   in the Windows version as CDFNI */

proc (1) = cdfinvn(p);
    local p0,p1,p2,p3,p4,q0,q1,q2,q3,q4,maskgt,maskeq,sgn,y,
          xp,pn,norms,mask1,mask0,inf0,inf1;

@ constants @


   p0 = -0.322232431088;                   q0 = 0.0993484626060;
   p1 = -1.0;                              q1 = 0.588581570495;
   p2 = -0.342242088547;                   q2 = 0.531103462366;
   p3 = -0.0204231210245;                  q3 = 0.103537752850;
   p4 = -0.453642210148*1e-4;              q4 = 0.38560700634*1e-2;

@ Main body of code @

  if not (p le 1.0 and p ge 0.0);
     errorlog("error: Probability is out of range.");
     retp(" ");
     end;
  endif;

/* Create masks for p = 0 or p = 1 */

   mask0 = (p .== 0);
   mask1 = (p .== 1);
   inf0 = missrv(miss(mask0,1),-1e+300);
   inf1 = missrv(miss(mask1,1),1e+300);

@ Create masks for handling p > 0.5 and p >= 0.5 @

   maskgt = (p .> 0.5);
   maskeq = (p .ne 0.5);
   sgn = missrv(miss(maskgt,0),-1);

@ Convert p > 0.5 to 1-p @
  pn = (maskgt-p).*sgn+mask1+mask0;   clear maskgt;

@ Computation of function for p < 0.5 @

  y=sqrt(abs((-2*ln(pn))));     clear pn;

  norms = y + ((((y*p4+p3).*y+p2).*y+p1).*y+p0)./
          ((((y*q4+q3).*y+q2).*y+q1).*y+q0);   clear y;
@ Convert results for p > 0.5 and p = 0.5 @

  norms=((norms.*sgn).*maskeq).*(1-mask0).*(1-mask1)+mask0.*inf0+mask1.*inf1;
  retp(norms);
endp;




