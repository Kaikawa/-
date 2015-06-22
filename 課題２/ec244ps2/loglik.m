%Calculate loglikelihood function for standard logit model
%Written by kenneth Train on Dec 11, 2007.

%Inputs: coef is Kx1 where K is number of explanatory variables
%
%Globals: NCS: scale number of choice situations
%         IDCASE: NROWSx1 vector identifying the rows for each choice situation (1-NCS), where NROWS is number of alternatives
%                          in all choice situations combined
%         IDDEP: NROWSx1 vector identifying the chosen alternative (1=chosen, 0=nonchosen)
%         VARS: NROWSxK matrix of explanatory variables

function ll=loglik(coef);

global NCS IDCASE IDDEP VARS XMAT
p=zeros(NCS,1);
v=VARS*coef(1:2,:);
mt=XMAT(:,9);
vl=XMAT(:,11);

for n=1:NCS
  if mt(n*5-4,1)==1 | vl(n*5-4,1)==1
  vv=v(IDCASE==n,1)*coef(end);
  vy=v(IDCASE==n & IDDEP==1,1)*coef(end);
  else
  vv=v(IDCASE==n,1);
  vy=v(IDCASE==n & IDDEP==1,1);
  end
  
  vv=vv-repmat(vy,size(vv,1),1);
  p(n,1)=1/sum(exp(vv));
end

p=max(p,0.00000001); %As a precaution

ll=-sum(log(p),1);  %Negative since neg of ll is minimized


