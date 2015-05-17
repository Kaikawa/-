The file sample2.cmd does exercises 2-5 of ps01.logit. The output is sample2.out.

The file frcst2.cmd does exercises 6-8. The output is frcst2.out.

I discuss the answers to this problem set at the start of the lecture entitled "Numerical Maximization." However, the relevant information is given below, such that you do not need to listen to that part of the lecture unless you just want to.

ANSWERS:
2. Now modify the code to run a model with installation cost and operating cost, leaving out pb.  

(a) Do the estimated coefficients have the expected signs? 

Yes, they are negative as expected, meaning that as the cost of a system rises (and the costs of the other systems remain the same) the probability of that system being chosen falls. 

(b) Are both coefficients significantly different from zero?

Yes, the t-statistics are greater than 1.96, which is the critical level for 95% confidence level.  

(c) How closely do the average probabilities (from the cova command) match the shares of customers choosing each alternative?

Not very well. 63.67% of the sample chose the first alternative (as shown at the top of the logit estimation) and yet the estimated model gives an average probability of only 51.695% (as shown in the cova output). The other alternatives are also fairly poorly predicted. We will find how to fix this problem in one of the models below.

(d) The ratio of coefficients usually provides economically meaningful information. The willingness to pay (wtp) through higher installation cost for a one-dollar reduction in operating costs is the ratio of the operating cost coefficient to the installation cost coefficient. What is the estimated wtp from this model? 

U=-.00623181 IC -.00457988 OC
So, find -dIC/dOC that keeps U constant.
dU=-.00623181 dIC -.00457988 dOC = 0
-.00623181 dIC = .00457988 dOC
-dIC/dOC= .00457988 / .00623181 = .73

The model implies that the decision-maker is willing to pay $.73 (ie., 73 cents) in higher installation cost in order to reduce annual operating costs by $1.


Is it reasonable in magnitude?

No. A $1 reduction in annual operating costs recurs each year. It is unreasonable to think that the decision-maker is only willing to pay only 73 cents as a one-time payment in return for a $1/year stream of saving. This unreasonable implication is another reason (along with the inaccurate average probabilities) to believe this model is not so good. We will find below how the model can be improved. 

(e) We can use the estimated wtp to obtain an estimate of the discount rate that is implied by the model of choice of operating system. The present value of the future operating costs is the discounted sum of operating costs over the life of the system: PV=sum[OC/(1+r)^t] where r is the discount rate and the sum is over t=1,...,L with L being the life of the system. As L rises, the PV approaches (1/r)OC. Therefore, for a system with a sufficiently long life (which we will assume these systems have), a one-dollar reduction in OC reduces the present value of future operating costs by (1/r). This means that if the person choosing the system were incurring the installation costs and the operating costs over the life of the system, and rationally traded-off the two at a discount rate of r, the decisionmaker's wtp for operating cost reductions would be (1/r). Given this, what value of r is implied by the estimated wtp that you calculated in part (c)? 

U=a LC where LC is lifecycle cost, equal to the sum of installation cost and the present value of operating costs: LC=IC+(1/r)OC. Substituting, we have
U=aIC + (a/r)OC.

The models estimates a as -.00623 and a/r as -.00457. So r = a/(a/r)=-.000623/.00457 = 1.36
or 136% discount rate. 

Is this reasonable?

No. It is far too high.

3. Estimate a model that imposes the constraint that r=.12 (such that wtp=8.33). Test the hypothesis that r=.12.

To impose this constraint, we create a lifecycle cost that embodies the constraint (see the lines "set lcc1=ic1+(1/.12)oc" etc) and estimate the model with this variable. We perform a likelihooid ratio test. The LL for this constrained model is  -1248.7. The LL for the unconstrained model (the first model in this output file) is -1095.2. The test statistic is twice the difference in LL: 2(1248.7-1095.2)=307. There test is for one restriction (ie a restiction on the relation of the coefficient of operating cost to that of installation cost.) We therefore compare 307 with the critical value of chi-sq with 1 degree of freedom. This critical value for 95% confidence is 3.8. Since the statistic exceeds the critical value, we reject the hypothesis that r=.12. 

4. Add alternative-specific constants to the model. 

(a) How well do the estimated probabilities match the shares of customers choosing each alternative? Note that they match exactly: alternative-specific constants in a logit model insure that the average probabilities equal the observed shares.

(b) Calculate the wtp and discount rate r that is implied by the estimates. 

wtp = .00699672 / .00153281 = 4.56. The decision-maker is willing to pay $4.56 for a $1/yr stream of savings.

r = 0.22. The decision-maker applies a 22% discount rate.

Are these reasonable?

They are certainly more reasonable that in the previous model. The decision-maker is still estimated to be valuing saving somewhat less than would seem rational (ie applying a higher discount rate than seems reasonable). However, we need to remember that the decision-maker here is the builder. If home buyers were perfectly informed, then the builder would adopt the buyer's discount rate. However, the builder would adopt a higher discount rate if home buyers were not perfectly informed about (or believed) the stream of saving. 

(c) This model contains constants for alternatives 1-4, with the constant for alternative 5 normalized to zero. Suppose you had included constants for alternatives 1,3,4, and 5, with the constant for alternative 2 normalized to zero. What would be the estimated coefficient of the constant for alternative 1? Figure this out logically rather than actually estimating the model.

We know that when the c5 is left out, the constant for alt 1 is 1.71074 meaning that the average impact of unicluded factors is 1.71074 higher for alt 1 than alt 5. Similarly, the constant for alt 2 is 0.30777. If c2 were left out instead of c5, then all the constants would be relative to alt 2. The constant for alternative 1 would the be 1.71074-.30777=1.40297. That is, the average impact of unincluded factors is 1.40297 higher for alt 1 than alt 2. Similarly for the other alternatives. 
Note the the constant for alt 5 would be 0-.30777=-.3077, since c5 is normalized to zero in the model with c5 left out.

5. Now try some models with sociodemographic variables entering.

(a) Does dividing installation cost by income seem to make the model better or worse?

The model seems to get worse. The LL is lower (more negative) and the coefficient on installation cost becomes insignificant (t-stat below 2).

(b) Instead of dividing installation cost by income, enter alternative-specific income effects. 
What do the estimates imply about the impact of income on the choice of central systems versus room system?

The model implies that as income rises, the probability of heat pump rises relative to all the others (since income in the heat pump alt is normalized to zero, and the others enter with negative signs such that they are lower than that for heat pumps. Also, as income rises, the probability of gas room drops relative to the other non-heat-pump systems (since it is most negative). 



Do these income terms enter significantly?

No. It seems that income doesn't really have an effect. Maybe this is because income is for the family that lives in the house, whereas the builder made decision of which system to install.

(c) Try other models. Determine which model you think is best from these data.

I'm not going to give what I consider my best model: your ideas on what's best are what matter here. 

7. The California Energy Commission (CEC) is considering whether to offer rebates on heat pumps. How much do the rebates raise the share of houses with heat pumps?

We estimate the model with the actual costs. Then we change the costs and calculate probabilities with the new costs. The average probability is the predicted share for an alternative. At the original costs, the heat pump share is .0555 (ie, about 5.5%) This share is predicted to rise to .0645 (about 6.5%) when rebates are given. 

8. Suppose a new technology is developed that provides more efficient central heating. What is the predicted market share for the new technology? 

The new technology captures a market share of 0.1036. That is, it gets slightly more than ten percent of the market.
 
From which of the original five systems does the new technology draw the most customers?

It draws the same percent (about 10%) from each system. This means that it draws the most in absolute terms from the most popular system, gas central. For example, gas central drops from to .637 to .571; this is an absolute drop of .637-.571=.065 and a percent drop of .065/.637= about 10%. Of the 10.36% market share that is attained by the new technology, 6.5% of it comes from gas central. The other systems drop by about the same percent, which is less in absolute terms. 

The same percent drop for all systems is a consequence of the IIA property of logit. To me, this property seems unreasonable in this application. The new technology is a type of electric system. It seems reasonable that it would draw more from other electric systems than from gas systems. Models like nested logit, probit, and mixed logit allow more flexible, and in this case, more realistic substitution patterns.

