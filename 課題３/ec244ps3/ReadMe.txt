The file nldata.asc contains data in ascii format on the choice of heating and central cooling system for 250 single-family, newly built houses in California. The data are held in the "long" format, where each line of data represents an alternative.

The alternatives are:

1. Gas central heat with cooling
2. Electric central resistence heat with cooling
3. Electric room resistence heat with cooling
4. Electric heat pump, which provides cooling also
5. Gas central heat without cooling
6. Electric central resistence heat without cooling
7. Electric room resistence heat without cooling

Heat pumps necessarily provide both heating and cooling such that heat pump without cooling is not an alternative.

The variables are:

1. idcase: identifies the house, 1-250.
2. idalt: identified the alternative, 1-7
3. Depvar: identifies whether the alternative was chosen, 1=chosen, 0=nonchosen
4. Installation cost, in dollars
5. Operating cost, in dollars per year 
6. Income of household, in thousands of dollars per year (such that 20 means $20,000 income)  

The file nest.m is a matlab file to estimate a nested logit model with two nests and the same nesting parameter for both nests, using the data in nldata.asc. It is specified to estimate a model with the cooling alternatives (1-4) in one nest and the non-cooling alternatives (5-7) in another nest.

1. Review the code and make sure you understand how the data are set-up and how the log-likelihood code, loglik.m, calculates the choice probabilities. Note the the code assumes that the same alternatives are avilable for all choice situations, which simplifies coding considerably. Run the program and verify that you get the same results as in myoutKT.txt. 

(a) The estimated log-sum coefficient is .54. What does this estimate tell you about the degree of correlation in unobserved factors over alternatives within each nest?

(b) Test the hypothesis that the log-sum coefficient is 1.0 (the value that it takes for a standard logit model.) Can the hypothesis that the true model is standard logit be rejected?

(c) What is the estimated willingness to pay for reduced operating costs, and the implicit discount rate? How do these compare with the estimated you obtained in problem sets 1 and 2 on the heating choice data?

2. Re-estimate the model with the room alternatives (3 and 7) in one nest and the central alternatives (1 2 4 5 6) in another nest. (Note that a heat pump is a central system.)

(a) What does the estimate imply about the substitution patterns across alternatives? Do you think the estimate is plausible?

(b) Is the log-sum coefficient significantly different from 1?

(c) How does the value of the log-likelihood function compare for this model relative to the model in exercise 1, where the cooling alternatives are in one nest and the heating alternatives in the other nest.

3. The log-likelihood proc applies the same log-sum coefficient to each nest. Rewrite the code to have a separate log-sum coefficient for each nest. Rerun the model that has the cooling alternatives in one nest and the non-cooling alternatives in the other nest (like for exercise 1), with a separate log-sum coefficient for each nest.

(a) Which nest is estimated to have the higher correlation in unobserved factors? Can you think of a real-world reason for this nest to have a higher correlation?

(b) Are the two log-sum coefficients significantly different from each other? That is, can you reject the hypothesis that the model in exercise 1 is the true model?

4. Rewrite the code to allow three nests. For simplicity, estimate only one log-sum coefficient which is applied to all three nests. Estimate a model with alternatives 1,2,3 in a nest, alternative 4 in a nest alone, and alternatives 5,6,7 in a nest. Does this model seem better or worse than the model in exercise 1, which puts alternative 4 in the same nest as alternatives 1,2,3.


