% Matlab code to estimate a standard logit model with maximum simulated likelihood
% Written by Kenneth Train, first version Dec 11, 2007, 

clear all

% Declare GLOBAL variables
% GLOBAL variables are all in caps
% DO NOT CHANGE ANY OF THESE 'global' STATEMENTS
global NCS NROWS XMAT
global IDV NAMES B PREDICT
global MAXITERS PARAMTOL LLTOL
global VARS IDCASE IDDEP IDALT


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
disp 'Standard logit of heating system choice of 900 houses, with explanatory vars: installation cost and operating cost.'

% DATA
        

% Number of choice situations in dataset.
NCS=900;     

% Total number of alternatives in all choice situations combined.
% This is the number of rows of data in XMAT below.
NROWS=900*5;

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
% The *third* column of XMAT identifies the chosen alternatives (1 for
% chosen, 0 for not). One and only one alternative must be chosen for each
% choice situation.
% The remaining columns of XMAT can be any variables.

XMAT=load('datalong.asc');  %The variables are described below
XMAT(:,4:5:6)=XMAT(:,4:5:6)./100; %To scale: costs in hundreds of dollars
newvar=XMAT(:,4)/XMAT(:,6);
XMAT=[XMAT newvar];

% 1. idcase: gives the observation number (1-900)
% 2. idalt: gives the alternative number (1-5)
% 3. depvar: identifies the chosen alternative (1=chosen, 0=nonchosen)
% 4. ic: installation cost of system, in hundreds of dollars
% 5. oc: operating cost of the system, in hundreds of dollars
% 6. income is the annual income of the household
% 7. agehed is the age of the household head
% 8. rooms is the number of rooms in the house
% 9. ncostl identifies whether the house is in the northern coastal region
% 10. scostl identifies whether the house is in the southern coastal region
% 11. mountn identifies whether the house is in the mountain region
% 12. valley identifies whether the house is in the central valley region

%Identify the columns of XMAT that you want to enter as explanatory variables in the model.

IDV=[13 5];

%Give names to the variables. Put the names in single quotes.'}

NAMES={'newvar' 'oc' };

%Gives starting values for the coefficients of these variables.

B=[0 0 ];

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
