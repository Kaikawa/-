% Matlab code to estimate a nested logit model with maximum simulated likelihood
% with two nests and the same nesting parameter for both nest.
% Requires the same alternatives are avilable in each choice situation
% Written by Kenneth Train, Jan 6, 2008, by resiving logit.m. 

clear all

% Declare GLOBAL variables
% GLOBAL variables are all in caps
% DO NOT CHANGE ANY OF THESE 'global' STATEMENTS
global NCS NROWS XMAT
global IDV NAMES B PREDICT
global MAXITERS PARAMTOL LLTOL
global VARS IDCASE IDDEP IDALT
global NALT NEST1 LAMBDA NESTS


% OUTPUT FILE
% Put the name you want for your output file (including full path if not the current 
% working directory) after words "delete" and "diary".
% The 'diary off' and 'delete filename' commands close and delete the previous version 
% of the file created during your current matlab session or in any previous sessions. 
% If you want to append the new output to the old output, then 
% put % in front of the 'diary off' and 'delete filename' commands (or erase them).

diary off
delete myrun.out
diary myrun.out

% TITLE
% Put a title for the run in the quotes below, to be printed at the top of the output file.
disp 'Nested logit of heating and cooling system choice of 250 houses.'

% DATA
        

% Number of choice situations in dataset.
NCS=250;  

% Number of alternatives for each choice situation
NALT=7;   

% Total number of alternatives in all choice situations combined.
% This is the number of rows of data in XMAT below.
%DO NOT CHANGE THIS LINE
NROWS=NCS*NALT;

% Load and/or create XMAT, a matrix that contains the data.
%
% XMAT must contain one row of data for each alternative in each choice situation.
% The rows are grouped by choice situations.
% The number of rows in XMAT must be NROWS, specified above.
% The columns in XMAT are variable that describe the alternative.
% 
% The *first* column of XMAT identifies the choice situation. 
% The choice situations must be numbered sequentially from 1 to NCS, in ascending order.
% The *second* column of XMAT identifies the alternative for each choice situation.
% All alternatives for a given choice situation must be grouped together.
% The alternatives must be listed in the same order for all choice situations,
% and must be numbered sequentially from 1 to NALT.
% The *third* column of XMAT identifies the chosen alternatives (1 for
% chosen, 0 for not). One and only one alternative must be chosen for each
% choice situation.
% The remaining columns of XMAT can be any variables.

XMAT=load('nldata.asc');  %The variables are described below
XMAT(:,4:5)=XMAT(:,4:5)./100; %To scale: costs in hundreds of dollars
% Create extra variables to enter
XMAT=[XMAT (XMAT(:,6).*(XMAT(:,2) <= 4))]; %Income entering for cooling systems
%Create alt specific constants
for i=1:NALT;
  XMAT=[XMAT (XMAT(:,2)==i)];
end

% 1. idcase: gives the observation number (1-250)
% 2. idalt: gives the alternative number (1-7)
% 3. depvar: identifies the chosen alternative (1=chosen, 0=nonchosen)
% 4. ic: installation cost of system, in hundreds of dollars
% 5. oc: operating cost of system, in hundreds of dollars
% 6. income is the annual income of the household, in thousands of dollars
% 7. income entering for cooling systems (alts 1-4)
% 8-14. ASCs for alts 1-7


%Identify the columns of XMAT that you want to enter as explanatory variables in the model.

IDV=[4 5 7 9 10 11 12 13 14];

%Give names to the variables. Put the names in single quotes.'}

NAMES={'ic' 'oc' 'inccool' 'asc2' 'asc3' 'asc4' 'asc5' 'asc6' 'asc7' };

%Gives starting values for the coefficients of these variables.
      
B=zeros(1,size(IDV,2));

%Identify the alternatives that you want to enter the first nest.
%The alternatives that are not listed in NEST1 are necessarily put into the second nest.

NEST1=[1 2 3 4]; %The cooling alternatives

%Give a starting value for the nesting parameter.
%The parameter is defined such that LAMBDA=1 gives a standard logit model
 
LAMBDA=[1 ];

%Do you want to predict probabilities and aggregate shares for each alternative?
%Predicted shares are given for each unique value (ie alternative number) in the second column of XMAT.
%Predicted probabilities for each alternative in each choice situation are held in vector probs, which is NROWSx1.
%Set PREDICT=0 to estimate only and not predict
%    PREDICT=1 to estimate the model and then predict at the estimated coefficients
%    PREDICT=2 to predict at the starting values B and not estimate

PREDICT=1;

% OPTIMIZATION 
% Maximum number of iterations for the optimization routine.
% The code will abort after ITERMAX iterations, even if convergence has
% not been achieved. The default is 400, which is used when MAXITERS=[];
MAXITERS=[];

% Convergence criterion based on the maximum change in parameters that is considered
% to represent convergence. If all the parameters change by less than PARAMTOL 
% from one iteration to the next, then the code considers convergence to have been
% achieved. The default is 0.000001, which is used when PARAMTOL=[];
PARAMTOL=[];

% Convergence criterion based on change in the log-likelihood that is
% considered to represent convergence. If the log-likelihood value changes
% less than LLTOL from one iteration to the next, then the optimization routine
% considers convergence to have been achieved. The default is 0.000001,
% which is used when LLTOL=[];
LLTOL=[];

%Do not change the next line. It runs the model.
doit
