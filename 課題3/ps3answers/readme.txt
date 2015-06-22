The results of this problem set are discussed at the beginning of the lecture entitled "Probit." The answers that relate to interpretation of the output are discussed below. The changes in the code are discussed in the lecture and not below.

nested2.txt, nested3.txt and nested4.txt do exercises 2, 3, and 4, respectively. The outputs are nestout2.txt, nestout3.txt, and nestout4.txt. 

1. (a) The estimated log-sum coefficient is .59. What does this estimate tell you about the degree of correlation in unobserved factors over alternatives within each nest?

The correlation is approximately 1-.59=.41. It's a moderate correlation.

(b) Test the hypothesis that the log-sum coefficient is 1.0 (the value that it takes for a standard logit model.) Can the hypothesis that the true model is standard logit be rejected?

We can use a t-test of the hypothesis that the log-sum coefficient =1. The t-statistic is (.5856-1)/.1665 = .4144/.1665 = 2.49. The critical value of t for 95% confidence is 1.96. So we can reject the hypothesis at 95% confidence. 

2. Re-estimate the model with the room alternatives in one nest and the central alternatives in another nest. (Note that a heat pump is a central system.)

(a) What does the estimate imply about the substitution patterns across alternatives?

The log-sum coefficient is over 1. This implies that there is more substitution across nests than within nests. 

Do you think the estimate is plausible?

I don't think this is very reasonable, but people can differ on their concepts of what's reasonable.

(b) Is the log-sum coefficient significantly different from 1?

The t-statistic is (1.3621-1)/.5544 = .3621/.554 < 1. We cannot reject the hypothesis at standard confidence levels.

(c) How does the value of the log-likelihood function compare for this model relative to the model in exercise 1, where the cooling alternatives are in one nest and the heating alternatives in the other nest.

The LL is worse (more negative.) All in all, this seems like a less appropriate nesting structure.

3. The log-likelihood proc applies the same log-sum coefficient to each nest. Rewrite the code to have a separate log-sum coefficient for each nest. Rerun the model that has the cooling alternatives in one nest and the non-cooling alternatives in the other nest (like for exercise 1), with a separate log-sum coefficient for each nest.

Which nest is estimated to have the higher correlation in unobserved factors? 

(a) The correlation in the cooling nest is around 1-.60 = .4 and that for the non-cooling nest is around 1-.45 = .55. So the correlation is higher in the non-cooling nest.

Can you think of a real-world reason for this nest to have a higher correlation?
Perhaps more variation in comfort when there is no cooling. This variation in comfort is the same for all the non-cooling alternatives.

(b) Are the two log-sum coefficients significantly different from each other? That is, can you reject the hypothesis that the model in exercise 1 is the true model?

The restricted model is the one from exercise 1 that has one log-sum coefficient. Its LL is -.712499. The unrestricted model is the one we just estimated. Its LL is -.711240. Both of the LL's are the average LL in the sample (that is LL/N where N is sample size: that's what maxlik gives as output for LL). The LL is therefore 250 times these amounts, since sample size is 250. The test statistics is 2*(.712499-.711240)*250=.6295. The critical value of chi-squared with 1 degree of freedom is 3.8 at the 95% confidence level. We therefore cannot reject the hypothesis that the two nests have the same log-sum coefficient.

4. Rewrite the code to allow three nests. For simplicity, estimate only one log-sum coefficient which is applied to all three nests. Estimate a model with alternatives 1,2,3 in a nest, alternative 4 in a nest alone, and alternatives 5,6,7 in a nest. Does this model seem better or worse than the model in exercise 1, which puts alternative 4 in the same nest as alternatives 1,2,3.

The LL for this model is -.719261, which is lower (more negative) than for the model with two nests, which got -.712499.
