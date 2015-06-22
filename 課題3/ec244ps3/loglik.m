%Calculate loglikelihood function for nested logit model under specifications in nest.m
%Written by kenneth Train on Jan 6, 2008.

%Inputs: coef is (K+1)x1 where K is the number of explanatory variables, and the last element is the nesting parameter.
%
%Globals: NCS: scalar number of choice situations
%         NALT: scalar number of alternatives in each choice situation
%         IDDEP: NROWSx1 vector identifying the chosen alternative (1=chosen, 0=nonchosen)
%         VARS: NROWSxK matrix of explanatory variables
%         NESTS: NALTx1 vector identifying nest of each alternative, 1 or 2

function ll=loglik(coef);

global NCS NALT IDDEP VARS NESTS

p=zeros(NCS,1);
v=VARS*coef(1:end-1,1);
lm=coef(end,1);
v=v./lm;          %Normalize by nesting paramater
v=exp(v);
v=reshape(v,NALT,NCS);     %NALTxNCS
y=reshape(IDDEP,NALT,NCS); %NALTxNCS: 0-1 for chosen alt

% p=sum(y.*v,1)./sum(v,1);

yn1=sum(y(NESTS==1,:),1);   %1xNCS: Identifies whether chosen alt is in nest 1
vn1=sum(v(NESTS==1,:),1);   %1xNCS: Sum of exponentialed utility for nest 1
vn2=sum(v(NESTS==2,:),1);   %1xNCS: Sum of exponentiated utility for nest 2
yv=sum(v.*y,1);             %1xNCS: Exponentiated utility of chosen alternative

p=yv.*( (yn1.*vn1 + (1-yn1).*vn2) .^(lm-1)  ) ./  (vn1.^lm + vn2.^lm);


p=max(p,0.00000001); %As a precaution


ll=-sum(log(p),2);  %Negative since neg of ll is minimized


