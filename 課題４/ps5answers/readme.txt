Files modmxl3.g and modmxl4.g do exercises 3 and 4.
The output is out3.txt and out4.txt

Files mxlp6.g and mxlp7.g do exercises 6 and 7.
The output is output6.txt and output7.txt.

Answers:
2. (a) Using the estimated mean coefficients, determine the amount that a customer with average coefficients for price and length is willing to pay for an extra year of contract length. 

The mean coefficient of length is -.1808. The consumer with this average coefficient dislikes having a longer contract. So this person is willing to pay to reduce the length of the contract. The mean price coefficient is -.8916. A customer with these coefficients is willing to pay .1808/.8916=0.20, or one-fifth a cent per kWh extra to have a contract that is one year shorter. 

(b) Determine the share of the population who are estimated to dislike long term contracts (ie have a negative coefficient for the length.)

The coefficient of length is normally distributed with mean -.1808 and standard deviation .3602. The share of people with coefficients below zero is the cumulative probability of a standardized normal deviate evaluated at .1808/.3602=.502. Looking .502 up in a table of the standard normal distribution, we find that the share below .502 is .70. Seventy percent of the population are estimated to dislike long-term contracts. 

3. Determine the share of customers with positive price coefficients.

The price coefficient is distributed normal with mean -.8916 and standard deviation .1535. The cumulative standard normal distribution evaluated at .8916/.1535=5.8 is more than .999, which means that more than 99.9% of the population are estimated to have negative price coefficients. Essentially no one is estimated to have a positive price coefficient.

4. The price coefficient is uniformly distributed from 0 to an estimated upper bound of 2.9317. The estimated price coefficient is -.8570, and so the willingness to pay for a known provided ranges uniformly from 0 to 2.9317/.8570 = 3.4 cents per kWh.

6. The robust standard errors are larger, as expected. Simulation noise causes the non-robust standard errors underestimate the true standard error; this underestimation disappears as the number of draws used in simulation rises.

7. The calculations are given at the bottom of output7.txt

 
