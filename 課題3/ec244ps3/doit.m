% Script to use with nest.m, to call optimizater and print results
% Written by Kenneth Train, Jan 6, 2008, based on revisions to code of same name used with logit.m

ok=check;  %Check the data
if ok == 1;
    disp('Inputs have been checked and look fine.');
else
    return;
end

VARS=XMAT(:,IDV);
IDCASE=XMAT(:,1);
if PREDICT > 0;
    IDALT=XMAT(:,2);
end;
IDDEP=XMAT(:,3);

%Create vector that identifies which nest each alternative is in

NESTS=2.*ones(NALT,1); %Alts are in nest 2 unless otherwise specified by NEST1
for i=1:size(NEST1,2);
  j=NEST1(1,i);
  NESTS(j,1)=1;
end;
   



if PREDICT == 2;
    disp('Predict shares at starting values B.');
    probs=pred([B LAMBDA]');
    disp('Since PREDICT=2, no estimation is done.');
    return;
end;

disp('Start estimation');
disp('The negative of the log-likelihood is minimized,');
disp('which is the same as maximizing the log-likelihood.');
tic;
param=[B LAMBDA]';  %starting values: collect coefficients and nesting parameter, take transpose since must be col vector
options=optimset('LargeScale','off','Display','iter','GradObj','off',...
    'MaxFunEvals',10000,'MaxIter',MAXITERS,'TolX',PARAMTOL,'TolFun',LLTOL,'DerivativeCheck','off');
[paramhat,fval,exitflag,output,grad,hessian]=fminunc(@loglik,param,options);

disp(' ');
disp(['Estimation took ' num2str(toc./60) ' minutes.']);
disp(' ');
if exitflag == 1
  disp('Convergence achieved.');
elseif exitflag == 2
  disp('Convergence achieved by criterion based on change in parameters.');
  if size(PARAMTOL,1)>0
     disp(['Parameters changed less than PARAMTOL= ' num2str(PARAMTOL)]);
  else
     disp('Parameters changed less than PARAMTOL=0.000001, set by default.');
  end
  disp('You might want to check whether this is actually convergence.');
  disp('The gradient vector is');
  grad
elseif exitflag == 3
  disp('Convergence achieved by criterion based on change in log-likelihood value.');
  if size(PARAMTOL,1)>0
     disp(['Log-likelihood value changed less than LLTOL= ' num2str(LLTOL)]);
  else
     disp('Log-likelihood changed less than LLTOL=0.000001, set by default.');
  end
     disp('You might want to check whether this is actually convergence.');
     disp('The gradient vector is');
     grad
else
    disp('Convergence not achieved.');
    disp('The current value of the parameters and hessian');
    disp('can be accesses as variables paramhat and hessian.');
    disp('Results are not printed because no convergence.');
    return
end

disp(['Value of the log-likelihood function at convergence: ' num2str(-fval)]);

%Calculate standard errors of parameters
disp('Taking inverse of hessian for standard errors.');
ihess=inv(hessian);
stderr=sqrt(diag(ihess));
disp(['The value of grad*inv(hessian)*grad is: ' num2str(grad'*ihess*grad)]);

disp(' ');
disp('ESTIMATION RESULTS');
disp(' ')
disp('              ---------------------------- ');
disp('                Est         SE      t-stat');
for r=1:size(NAMES,2);
    fprintf('%-10s %10.4f %10.4f %10.4f\n', NAMES{1,r}, [paramhat(r,1) stderr(r,1) paramhat(r,1)./stderr(r,1) ]);
end
fprintf('%-10s %10.4f %10.4f %10.4f\n', 'nestparam', [paramhat(end,1) stderr(end,1) paramhat(end,1)./stderr(end,1) ]);
disp(' ');

disp(' ');
disp('You can access the estimated parameters as variable paramhat,');
disp('the gradient of the negative of the log-likelihood function as variable grad,');
disp('the hessian of the negative of the log-likelihood function as variable hessian,');
disp('and the inverse of the hessian as variable ihess.');
disp('The hessian is calculated by the BFGS updating procedure.');

if PREDICT == 1;
    disp(' ');
    disp('Predict shares at estimated coefficients.');
    probs=pred(paramhat);
end;