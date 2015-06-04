The purpose of this problem set is to help you develop an understanding of the numerical and programming aspect of model estimation. In this problem set we use and modify matlab codes that estimate logit models. The goal in this problem set is not to estimate logit models per se. As I said before, there are several commercially available software packages that will estimate logit model automatically, without the user needing to know how the estimation is actually performed. We use a logit model in this problem set because it provides a good starting point for learning how to code models in general. This skill enables you not to be bound to specifications that other people have already coded but rather to be free to code up your own model. 

The codes and dataset from problem set 1 have been copied into the folder for this second problem set, since we will start with those codes.

The matlab Optimization Toolbox contains several optimizers. The one we will be using is fminunc, which minimizes a user-defined function. Fminunc takes as an argument an .m file (ie, a matlab code) that calculates the value to be minimized. You can read the documentation of the Optimization Toolbox for complete instructions on the optimizers and their arguments. In our case, we are maximizing the log-likelihood function, which is the same as mimimizing the negative of the log-likelihood function. 

1. Start by looking at the .m files. Make sure that you understand the logic and what they each do. 

In doit.m, the relevant lines for the optimizer are:

(a) param=B';  %starting values: take transpose since must be col vector
(b) options=optimset('LargeScale','off','Display','iter','GradObj','off',...
        'MaxFunEvals',10000,'MaxIter',MAXITERS,'TolX',PARAMTOL,'TolFun',LLTOL,'DerivativeCheck','off');
(c) [paramhat,fval,exitflag,output,grad,hessian]=fminunc(@loglik,param,options);

Line (c) is the call to the optimzer, and lines (a) and (b) create information that the optimizer uses. The file loglik.m calculates the negative of the log-likelihood. As you see, it takes one argument (a column vector of parameters) and returns a scalar (the negative log-likelihood value). Fminunc requires that the function being minimized take only one argument, and so any data that is passed to the function must be held as global variables. 

Note that in line (b), we have set the 'GradObj' option to 'off'. This tells fminunc to calculate gradients numerically. It does this by making a small change in each parameter (one at a time), calculating the function again at this new parameter value, and calculating the derivative as the change in the function divided by the change in the parameter. This means that each iteration of the optimizer requires K+1 calculations of the function if there are K parameters. This can be very slow if there are many parameters and the dataset is large. Later in the problem set we will explore the use of analytic gradients.

Line (c) says that the estimated parameters are put into a vector called "paramhat", the value of the function at the estimates is put into "fval", the gradient is "grad", and the hessian is "hessian". (You can of course change these names if you want.) Fminunc does not calculate standard errors, and so we have to do that ourselves. The following lines in doit.m calculate the covariance matrix as the inverse of the hessian, and the standard errors as the square root of the diagonal elements of this covariance. The relevant lines are:
%Calculate standard errors of parameters
disp('Taking inverse of hessian for standard errors.');
ihess=inv(hessian);
stderr=sqrt(diag(ihess));

where ihess is the covariance matrix for the parameters.

There are two things to note about this covariance matrix.  Recall that the asymptotic covariance of the parameters in maximum likelihood estimation is inv(-H)/N, where H is the hessian of the expected log-likelihood, N is sample size, and inv() denotes inverse.  In our code, we are calculating the covariance as "inv(hessian)", without the negative and without dividing by N. Here's why: (1) The negative of "hessian" is not taken because the function that enters fminunc is the negative of the log-likelihood. The hessian of this function already has the negative incorporated: the hessian of the negative of the log-likelihood is the negative of the hessian of the log-likelihood itself. (2) The "hessian" is not divided by N because the log-likelihood function is specified as the sum of the log-likelihood over sampled observations, rather than the mean of them. The inverse of the "hessian" of this sum already incorporates the division by N. The covariance still drops as N rises, even though there is no explicit division by N: If sample size rises, the log-likelihood rises in magnitude, since it is a sum rather than an average and each element adds to ists magnitude. The hessian (which is the second derivative of this sum) also rises with N, such that its inverse decreases in N. 

You can specify loglik.m to calculate the average log-likelihood, by dividing by sample size. If you did this, then you will need to divide the hessian by N to get the covariance matrix. If you want, you could try this, to see if you get the same results both ways. 
 
2. In problem set 1, you estimated a model with alternative specific constants, by adding variables to XMAT and including them in the model. In most discrete choice models, you will want to include alternative specific constants, and so it would help to have the code estimate them automatically. Revise the relevant .m files to contain an option for the user to request alternative-specific constants and for them to be estimated automatically when this option is specified. Hint: you can do this without needing to revise loglik.m or pred.m by creating the constants and appending them to VARS near the top of doit.m. Run your code to be sure that you get the same results as you did in problem set 1. 

3. The main reason you will want to write your own codes is because you want to estimate a model that standard statistical packages do not contain. An example is a logit model with a different scale parameter for different sub-populations. This different scaling would arise if the variance in unobserved factors is greater for one group than for another. 

Revise the codes to estimate one scale parameter, where this scale is applicable to a user-defined subset of the sample and a scale of 1 is used (by normalization) for observations that are not in this subset. For example, the group might be houses in the mountain and valley areas. Revise loglik.m such that the coefficients of houses in the identified group are multiplied by this scale parameter (or divided, if you'd prefer: think about which makes more sense to you.) This will add one parameter to the vector paramhat that enters fminunc. Estimate some models with this new scale parameter, trying different groups to see whether the scale is significantly different for any identifiable groups. (Hint: be sure to set the starting value of the new scale parameter to 1 rather than 0, since a value of 1 means that the scale for the two groups is the same.)

Different scale factors for different observations are particularly useful and important with rank-ordered data, for stated-preference data (whether rank-ordered or not), and when combining stated-preference and revealed-preference data. So you might want to save this program for future use. 

4. As mentioned above, the codes are currently set-up for fminunc to calculate numerical gradients. We now want to provide analytic gradients. For small jobs, the time spent coding analytic gradients is usually not worthwhile, since estimation with numerical gradients is sufficiently fast. But for large jobs, analytic gradients can be very helpful in reducing run times. 

The most succinct expression for the gradient for a logit model is:

g=SUM_n SUM_j (y_nj - P_nj)x_nj

where g is a Kx1 vector of the derivative of the log-likelihood with respect to the K coefficients
n denotes choice situation, with the sum over all sampled choice situations 
j denotes alternative, with the sum over all alternatives
y_nj is the 0-1 dependent variable (1 if j is chosen in choice situation n, 0 if j is not chosen in choice situation n)
P_nj is the logit probability of alternative j in choice situation n
x_nj is a Kx1 vector of the explanatory variables for alternative j in choice situation n.
 
Derive this formula yourself, from the definition of the log-likelihood function with logit probabilities. 

To use analytic gradients, fminunc expects them to be calculated in the same .m file that calculates the function that is being minimized. Revise loglik.m to calculate the gradient vector, renaming the file loglikgr.m. The first line specifies a second output of the function: 

function [ll,gr]=loglikgr.m

and then within the file create a vector gr as a column vector with the same length as coef. Be sure to calculate the NEGATIVE of the gradient in the above formula (ie gr=-g), since the function being minimized is the negative of the log-likelihood.

After you have written loglikgr.m, revise the lines in doit.m to (1) change @loglik to @loglikgr in the call to fminunc, so that it knows to use your new code, (2) change the options to say that analytic gradients will be used, by specifying the 'GradObj' option as 'on' instead of 'off', and (3) change the options to ask the code to check your analytic derivatives, by specifying the ''DerivativeCheck' option as 'on' instead of 'off'. This last option is very useful. Fminunc allows you to test whether your calculation of the analytic gradients gives the same answer as the numerical gradients. When you first run a code with analytic gradients, you should always do this test. It calculates numerical gradients in the first iteration (ie at the starting values) and, if they match the analytic derivatives, it proceeds in the other iterations with just the analytic gradients. If they don't match, it gives you an error message and terminates. Once you have checked your analytic gradients, you can turn 'off' the ''DerivativeCheck' option in future runs.



