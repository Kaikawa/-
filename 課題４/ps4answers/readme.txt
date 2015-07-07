The results of this problem set are discussed at the beginning of the lecture entitled "mixed logit."

probit3.txt does exercise 3. The output is pout3.txt.

pfc5.txt does exercise 5. The output is pfcout5.txt.

probit6.txt does exercise 6. The output is pout6.txt.


Answers to the interpretative questions:

2. The estimated Choleski factor L1 is =   1      0     0 
                                      .2887  .7497   0
                                     -.05276 .4832 .4448

Multiplying L1 by its transpose gives Omega1 =  1   .29 -.53
                                               .29  .65  .21
                                              -.53  .21  .71


With iid errors, omega1 would be =  1 .5 .5
                                   .5 1 .5
                                   .5 .5 1


I find it hard to tell anything from the estimated covariance terms. 

3. The estimates seem to change more for parameters with larger standard error, though this is not uniformly the case by any means. One would expect larger samplign variance (which arises from a flatter LL near the max) to translate into greater simulation variance (which raises when the location of the max changes with different draws).

4. The actual shares are given at the top of the pout.txt:
     0.48123620 
     0.070640177 
     0.17880795 
     0.26931567 
The predicted shares are given in pfcout.txt:
      0.48647092 
      0.069975340 
      0.17815697 
      0.26739377

The correspondence is very close but not exact. 

Note: Simulated GHK probabilities do not necessarily sum to one over alternatives. This summing-up error at the individual level tends to cancel out when the probabilities are averaged over the sample. The forecasted shares (ie, average probabilities) sum to 1.0019970, which is only slightly different from 1. 

5. Raise the cost of the car alone mode by 50% (do this within the pfct.txt program) and forecast shares at these higher costs. Is the substitution proportional, as a logit model would predict? Which mode has the greatest percent increase in demand? What is the percent change in share for each mode? 

Predicted shares with
Original costs    New costs   percent change
   .486             .288          -41%
   .070             .125          +79%
   .178             .227          +28%       
   .267             .361          +35%

Substitution is not proportional. Carpool gets the largest percent increase.

6. See pout6.txt for the coding. The estimates of s and r are s = 2.18 and r = 0.896. So the estimate of m is calculated as: s=m-2r, 2.18=m-2*0.896, m=2.18+2*0.896=3.97. 

Based on the estimation results: (i) How large is the variance of the unobserved factors relating to carpool, relative to the variances for the other modes? 

The variance for carpool is about 4 times greater than that for the other modes. A higher variance for carpool is to be expected since there are important aspects of carpooling (eg. coordinating schedules) that are not included in the model. 

(ii) What is the correlation between the unobserved utility of carpool and car alone? 

Estimated correlation = r / sqrt(1*m) = .896/sqrt(3.97) = 0.45.
             

