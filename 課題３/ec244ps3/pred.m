% Predicts probabilities and market shares for each alternative.
% For nested logit model, used with code nllogit.m.
% Written by Kenneth Train on Jan 6, 2008, based on version for standard logit.

%Inputs: coef is Kx1 where K is number of explanatory variables
%
%Globals: NCS: scale number of choice situations
%         IDCASE: NROWSx1 vector identifying the rows for each choice situation (1-NCS), where NROWS is number of alternatives
%                          in all choice situations combined
%         IDALT: NROWSx1 vector identifying the alternatives
%         IDDEP: NROWSx1 vector identifying the chosen alternative (1=chosen, 0=nonchosen)
%         VARS: NROWSxK matrix of explanatory variables
%         NESTS: NALTx1 vector identifying nest of each alternative, 1 or 2

%Output: probs: NROWSx1 vector of predicted probabilities for each alternative in each choice situation

function ps=pred(coef);

global NCS NALT IDDEP VARS NESTS

v=VARS*coef(1:end-1,1);
lm=coef(end,1);
v=exp(v./lm);
v=reshape(v,NALT,NCS);      %NALTxNCV: Exponentiated utility for each alt
vn1=sum(v(NESTS==1,:),1);   %1xNCS: Sum of exponentialed utility for nest 1
vn2=sum(v(NESTS==2,:),1);   %1xNCS: Sum of exponentiated utility for nest 2

denom=vn1.^lm + vn2.^lm;
probs=v.* ((repmat(vn1,NALT,1).*repmat(NESTS==1,1,NCS) + repmat(vn2,NALT,1).*repmat(NESTS==2,1,NCS)).^(lm-1)) ./repmat(denom,NALT,1);



%Sample and predicted shares
y=reshape(IDDEP,NALT,NCS); %NALTxNCS: 0-1 for chosen alt
ss=mean(y,2);
ps=mean(probs,2);


disp('Actual and predicted shares');
disp('     Alt      Actual    Predicted');
i=1:NALT;
disp([ i' ss ps ]);
disp('');
disp('Predicted probabilities are held in matrix probs, which has size NALTxNCS.');

