The purpose of this problem set is for you to develop an understanding of how to specify and interpret logit models. Many commerical software packages, such as STATA, SAS, and NLOGIT, contain logit estimation routines. Feel free to use these packages for this problem set if you want. However, I am providing an estimation routine in matlab, which you can use if you want. To run the matlab code, you need to have matlab and its optimization toolbox installed.

The problem set uses data on the choice of heating system in California houses. The observations consist of 900 single-family 
houses in California that were newly built and had central air-conditioning. The choice is among heating systems. 
Five types of systems are considered to have been possible:

(1) gas central, 
(2) gas room, 
(3) electric central, 
(4) electric room, 
(5) heat pump. 

There are two ways that data can be held for discrete choice models including logit: "wide" and "long". We have the data in both formats, so you can see the alternatives.

WIDE FORMAT

The wide format has one line of data for each observation (ie, for each choice situation.) The line of data contains the attributes of the decision-maker and the attributes of all the available alternatives. File "datawide.xls" is an excel file of our data in wide format.  Open the file and examine at the data. If you cannot read excel files, the data are also held in "datawide.asc" as a comma-delimited ascii (text) file, which you can open and view in any text editor. (Note that in the ascii file, the columns are not labeled. Also, the lines will wrap and so each line of data will appear as more than one line of text.) 

There are 900 lines of data with 19 variables on each line. The variables are:

1.  idcase: gives the observation number (1-900)
2.  depvar: identifies the chosen alternative (1-5)
3.  ic1: installation cost for a gas central system
4.  ic2: installation cost for a gas room system
5.  ic3: installation cost for a electric central system
6.  ic4: installation cost for a electric room system
7.  ic5: installation cost for a heat pump
8.  oc1: annual operating cost for a gas central system
9.  oc2: annual operating cost for a gas room system
10. oc3: annual operating cost for a electric central system
11. oc4: annual operating cost for a electric room system
12. oc5: annual operating cost for a heat pump
13. income: annual income of the household
14. agehead: age of the household head
15. rooms: number of rooms in the house
16. ncoast: identifies whether the house is in the northern coastal region
17. scoast: identifies whether the house is in the southern coastal region
18. mountn: identifies whether the house is in the mountain region
19. valley: identifies whether the house is in the central valley region

Note that the attributes of the alternatives, namely, installation cost and operating cost, take a different value for each alternative. Therefore, there are 5 installation costs (one for each of the 5 systems) and 5 operating costs. To estimate the logit model, the researcher needs data on the attributes of all the alternatives, not just the attributes for the chosen alternative. For example, it is not sufficient for the researcher to determine how much was paid for the system that was actually installed (ie., the bill for the installation). The researcher needs to determine how much it would have cost to install each of the systems if they had been installed. The importance of costs in the choice process (i.e., the coefficients of installation and operating costs) is determined through comparison of the costs of the chosen system with the costs of the non-chosen systems.
 
For these data, the costs were calculated as the amount the system would cost if it were installed in the house, given the characteristics of the house (such as size), the price of gas and electricity in the house location, and the weather conditions in the area (which determine the necessary capacity of the system and the amount it will be run.) These cost are conditional on the house having central air-conditioning. (That's why the installation cost of gas central is lower than that for gas room: the central system can use the air-conditioning ducts that have been installed.)

You'll see that the first household chose alternative 1 (gas central), has an income of $70,000, the head of household is 25 years old, the house has 7 rooms, and is located in the north coastal area.

LONG FORMAT

The long format has one line of data for each alternative of each choice situation. With 900 houses and 5 alternatives each, the long format has 4500 line of data. The term "observation" is often confusing for data held in the long format. From an econometric perspective, a choice situation is an observation, providing one element of the likelihood function. By this usage, an observation consists of several lines of data, one line for each alternative. From a data-holding perspective, each line of data is often called an observation, in which case, there are several "observations" for each choice situation. I will use the econometric meaning of an observation, but most package's documentation of logit estimation routines use the data-holding definition. 

The excel file datalong.xls holds our data in long format, as does ascii file datalong.asc. The variables are

1. Idcase: gives the observation number (1-900)
2. Idalt: gives the alternative number (1-5)
3. depvar: identifies the chosen alternative (1=chosen, 0=nonchosen)
4. ic: installation cost of system
5. oc: operating cost of the system
6. income is the annual income of the household
7. agehed is the age of the household head
8. rooms is the number of rooms in the house
9. ncostl identifies whether the house is in the northern coastal region
10. scostl identifies whether the house is in the southern coastal region
11. mountn identifies whether the house is in the mountain region
12. valley identifies whether the house is in the central valley region

Note that in the long format, the dependent variable is defined as 0-1 for whether or not the alternative was chosen; whereas in the wide format, the dependent variable is 1-5 identifying the number (or label) of the chosen alternative. Also, in the long format, the attributes of the decision-maker are repeated over all the alternatives.

Most software packages allow you to use either format. Usually, if there is a different number of alternatives for each choice situation, the long format is easier to use, since it includes as many lines as there are alternatives for each choice situation (ie, a different number of lines for different choice situations). In contrast, the wide format includes a variable for each attribute for each alternative that is available in any choice situation, which is missing or zero for choice situations that do not have that alternative as an option. On the other hand, the long format wastes some space by repeating the attributes of the decision-maker. 

For practice in matlab, you can write a matlab code that converts our data from wide format to long format, or vice-versa. (File widetolong.m does this, if you want to look at it.)

EXERCISES:


1. Run a logit model with installation cost and operating cost as the only explanatory variables. The file logit.m is a matlab file that allows you to specify and estimate a standard logit model. It is currently setup to run a logit with two explanatory variable: installation and operating costs. You can run the code as is, and the output will be written to myrun.out. Check this output against myrunKT.out, to be sure you get the same output as I got. 

If you have never run a matlab code before, here's what you need to do. Put all the files from this ps1 folder into a folder on your machine. Launch matlab, eg, by clicking on its icon. At the top of the workspace window in matlab, change the "Current Directory" to whatever folder you put the files in. The names of all the files will appear in the current directory sub-window on the left. Click on the filename logit.m, which will bring the file into an editor window. Then click on the run icon at the top right of this editor window (the icon looks like a tiny page of writing with a down-arrow next to it.)  

Just so you know what all the other files are: logit.m utilizes check.m, doit.m, loglik.m, and pred.m to check the data, call the optimizer, calculate the loglikelihood, and predict shares, respectively. These are transparent to the user: you don't need to see or revise them in order to estimate a logit model, unless you want to for some reason.

Evaluate the estimation results that you got from running logit.m. In particular:  

(a) Do the estimated coefficients have the expected signs?  

(b) Are both coefficients significantly different from zero?  

(c) How closely do the predicted shares match the actual shares of houses with each heating system?

(d) The ratio of coefficients usually provides economically meaningful information. The willingness to pay (wtp) through higher installation cost for a one-dollar reduction in operating costs is the ratio of the operating cost coefficient to the installation cost coefficient. What is the estimated wtp from this model? Is it reasonable in magnitude?  

(e) We can use the estimated wtp to obtain an estimate of the discount rate that is implied by the model of choice of operating system. The present value of the future operating costs is the discounted sum of operating costs over the life of the system: PV=sum[OC/(1+r)^t] where r is the discount rate and the sum is over t=1,...,L with L being the life of the system. As L rises, the PV approaches (1/r)OC. Therefore, for a system with a sufficiently long life (which we will assume these systems have), a one-dollar reduction in OC reduces the present value of future operating costs by (1/r). This means that if the person choosing the system were incurring the installation costs and the operating costs over the life of the system, and rationally traded-off the two at a discount rate of r, the decisionmaker's wtp for operating cost reductions would be (1/r). Given this, what value of r is implied by the estimated wtp that you calculated in part (c)? Is this reasonable?

2. Estimate a model that imposes the constraint that r=0.12 (such that wtp=8.33). Test the hypothesis that r=0.12.  To do this, you will need to create a new variable in XMAT. Here is how you create and use new variables in the matlab code: Suppose, for example, that you want to create a new variable that is the log of installation cost (this is NOT the variable you'll need to test whether r=0.12; I'm just using log installation cost as an example.) After XMAT is loaded, you add the lines:

newvar=log(XMAT(:,4));  %This creates a column vector that is the log of installation cost.
XMAT=[XMAT newvar];     %This appends the new column vector onto XMAT

The new variable is now the 13th variable in XMAT. (You'll probably want to write the names of new variables in the commented list of variables, to help remember them.) Then if you want to use log of installation cost, instead of installation cost, you specify the explanatory variables as:
IDV=[13 5];

3. Add alternative-specific constants to the model for alternatives 1-4. An alternative specific constant for alternative 1 is created by:

alt1=(XMAT(:,2) == 1);
XMAT=[XMAT alt1];

Remember that you can only add 4 constants since there are 5 alternatives; by adding constants for alts 1-4, you are normalizing the constant for alt 5 to zero.

(a) How well do the estimated probabilities match the shares of customers choosing each alternative? Note that they match exactly: alternative-specific constants in a logit model insure that the average probabilities equal the observed shares.

(b) Calculate the wtp and discount rate r that is implied by the estimates. Are these reasonable?

(c) Suppose you had included constants for alternatives 1,3,4, and 5, with the constant for alternative 2 normalized to zero. What would be the estimated coefficient of the constant for alternative 1? Figure this out logically rather than actually estimating the model.

4. Now try some models with sociodemographic variables entering.

(a) Enter installation cost divided by income, instead of installation cost. With this specification, the magnitude of the installation cost coefficient is inversely related to income, such that high income households are less concerned with installation costs than lower income households. Does dividing installation cost by income seem to make the model better or worse?

(b) Instead of dividing installation cost by income, enter alternative-specific income effects. The income variable for the 
first alternative is created like this:

incalt1=XMAT(:,6).*(XMAT(:,2) == 1)./1000;   %Where the division by 1000 scales income to be in thousands
XMAT=[XMAT incalt1];

Do similarly for alts2-4, with the coefficient for alt 5 normalized to zero.

What do the estimates imply about the impact of income on the choice of central systems versus room system? Do these income terms enter significantly?

(c) Try other models. Determine which model you think is best from these data.

5. We now are going to consider the use of the logit model for prediction. Specify a model with installation costs, operating costs, and alternative specific constants. Run the model (or retrieve your previous output). You'll be using this model for prediction below.

6. The California Energy Commission (CEC) is considering whether to offer rebates on heat pumps. The CEC wants to predict the effect of the rebates on the heating system choices of customers in California. The rebates will be set at 10% of the installation cost. The new installation cost will therefore be: 

newic=XMAT(:,4)-XMAT(:,4).*(XMAT(:,2) == 5)./10 ; %Where the division by 10 reduces alt5's cost by 10% 

Using the estimated coefficients from the model in part 5, calculate predicted shares under this new installation cost instead of original value. How much do the rebates raise the share of houses with heat pumps?








