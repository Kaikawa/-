% Predicts probabilities and market shares for each alternative.
% Written by Kenneth Train on Dec 11, 2007.

%Inputs: coef is Kx1 where K is number of explanatory variables
%
%Globals: NCS: scale number of choice situations
%         IDCASE: NROWSx1 vector identifying the rows for each choice situation (1-NCS), where NROWS is number of alternatives
%                          in all choice situations combined
%         IDALT: NROWSx1 vector identifying the alternatives
%         IDDEP: NROWSx1 vector identifying the chosen alternative (1=chosen, 0=nonchosen)
%         VARS: NROWSxK matrix of explanatory variables

%Output: probs: NROWSx1 vector of predicted probabilities for each alternative in each choice situation

function probs=pred(coef);

global NCS IDCASE IDALT IDDEP VARS

probs=zeros(size(VARS,1),1);
v=exp(VARS*coef);
for n=1:NCS;
   vv=v(IDCASE==n,1);
   denom=sum(vv);
   probs(IDCASE==n,1)=vv./denom;
end;

%Sample and predicted shares
ss=zeros(max(IDALT),1);
ps=ss;

for i=1:max(IDALT);
    ss(i,1)=mean(IDDEP(IDALT==i,1),1);
    ps(i,1)=mean(probs(IDALT==i,1),1);
end

disp('Actual and predicted shares');
disp('     Alt      Actual    Predicted');
i=1:max(IDALT);
disp([ i' ss ps ]);
disp('');
disp('Predicted probabilities are held in vector probs, which has size NROWSx1.');

