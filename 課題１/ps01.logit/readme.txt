The purpose of this problem set is for you to develop an understanding of how to specify and interpret logit models. This problem set uses SST, which is a language that is specially written for logit models and is very easy to use. I use SST in this problem set so that students can concentrate on the concepts without being overly burdened by programming. In all other problem sets, we use GAUSS code. GAUSS is more complex but allows essentially unlimited flexibility in specifying new models. SST is limited to standard logit. The GAUSS codes in the other problem sets can be used for nested logit, probit, and mixed logit, as well as standard logit; importantly, the GAUSS codes can be modified by the user for other models of the user's own design.

Since SST is used only in this first problem set, you might not want to bother buying and installing it. (It is available from Doug Rivers at Stanford and Jeff Dubin at Caltech.) The ps1answers folder contains the SST code and the output files for each exercise. If you do not have SST, you can examine the SST code files in ps1answers to see how you would need to change the SST code for each exercise; you can then look at the output file in ps1answers to see what output you would have gotten if you had run the SST code yourself. 

The dataset and SST code are described within the lecture entitled "Advantages and Limitations of Logit." However, I provide most of the needed information below and in exercises.txt, such that you can probably do the problem set without listening to that part of the lecture.  

The problem set uses data on choice of heating system in California houses. The file data1.sav contains the data in SST format. The observations consist of single-family houses in California that were newly built and had central air-conditioning. The choice is among heating systems. Five types of systems are considered to have been possible:

(1) gas central, 
(2) gas room, 
(3) electric central, 
(4) electric room, 
(5) heat pump. 

There are 900 observations with the following variables:

idcase gives the observation number (1-900)
depvar identifies the chosen alternative (1-5)
ic1 is the installation cost for a gas central system
ic2 is the installation cost for a gas room system
ic3 is the installation cost for a electric central system
ic4 is the installation cost for a electric room system
ic5 is the installation cost for a heat pump
oc1 is the annual operating cost for a gas central system
oc2 is the annual operating cost for a gas room system
oc3 is the annual operating cost for a electric central system
oc4 is the annual operating cost for a electric room system
oc5 is the annual operating cost for a heat pump
income is the annual income of the household
agehed is the age of the household head
rooms is the number of rooms in the house
ncostl identifies whether the house is in the northern coastal region
scostl identifies whether the house is in the southern coastal region
mountn identifies whether the house is in the mountain region
valley identifies whether the house is in the central valley region

Note that the attributes of the alternatives, namely, installation cost and operating cost, take a different value for each alternative. Therefore, there are 5 installation costs (one for each of the 5 systems) and 5 operating costs. To estimate the logit model, the researcher needs data on the attributes of all the alternatives, not just the attributes for the chosen alternative. For example, it is not sufficient for the researcher to determine how much was paid for the system that was actually installed (ie., the bill for the installation). The researcher needs to determine how much it would have cost to install each of the systems if they had been installed. The importance of costs in the choice process (i.e., the coefficients of installation and operating costs) is determined through comparison of the costs of the chosen system with the costs of the non-chosen systems.
 
For these data, the costs were calculated as the amount the system would cost if it were installed in the house, given the characteristics of the house (such as size), the price of gas and electricity in the house location, and the weather conditions in the area (which determine the necessary capacity of the system and the amount it will be run.) These cost are conditional on the house having central air-conditioning. (That's why the installation cost of gas central is lower than that for gas room: the central system can use the air-conditioning ducts that have been installed.)

The file sample.cmd is a text file of SST commands. It runs a logit
model on the data in data1.sav.

The file sample.out is the output from sample.cmd.

The file frcst.cmd is a text file of SST commands. It runs a logit
model and explicitly calculates the choice probabilities. It is used
in the exercises to do forecasting.

