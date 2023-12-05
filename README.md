# Reproducible research: version control and R

## Question 4

1) In executing this code, two graphs are produced which seem to demonstrate the path of random motion from time 1 to 500. This motion is plotted on a two dimensional field which is represented by the x and y axes of the graph. Despite the functions and graphing code being the same, with different randomised walks in each dataset, the two graphs show individually unique and random motion. The legend allows for interpretation of where the path starts and finishes. This is important as without the colour spectrum representing the chronological motion, overlaps in the path could lead to confusion. 

2) The term "random seeds" usually refers to the initial value used to initialize a pseudorandom number generator. This is an algorithm that generates a sequence of numbers that appears to be random but is actually deterministic. Given the same initial seed, a PRNG will produce the same sequence of "random" numbers. Changing the seed will result in a completely different 'randomised' behaviour that is due to a different initial value. 

3) Therefore, in the context of this code, a random seed can be used to generate the apparent random behaviour that is observed in the plotted graphs. A new random seed can be generated with each use of the function 'random_walk' which has been changed to generate a 'random' sequence of motion that is asigned to a specific seed. The function achieves this by setting parameters such that each next step in the sequence will orient in a new direction and assume a new coordinate (x,y) on the plot. 'data1' and 'data2' are both defined using this function, and everytime these datasets are used, they will produce the same behaviour because their seed is set. If a new dataset was created (e.g., data3 <- random_walk(500, seed = 44)), or the original datasets are redefined (by running the object code again with new seed values) then an entirely new 'random' behaviour would be observed. In this way, random seeds can be used to establish plots of random behaviour, that can be recalled and compared.  

4) Below are images attached to show a comparison between the original random_walk code and the new brownian motion code that now uses random seeds to set predetermined brownian motion behaviours:

<img width="1260" alt="code_comparison_1" src="https://github.com/Zephyr-Goriely/reproducible-research_homework/assets/150150268/f791f61f-fb4a-49ea-b542-2af3f85d4f20">
<img width="1259" alt="code_comparison_2" src="https://github.com/Zephyr-Goriely/reproducible-research_homework/assets/150150268/bdc8486c-8c55-4576-863d-e7e6bbd8bb42">

## Question 5

1) The CSV table containing the dataset of dsDNA viruses has 13 columns and 33 rows

2) The data is currently under the relationship explained by this equation: **$`V = \beta L^{\alpha}`$**. This relationship is an exponential. By taking a log transformation of both sides of the equation, a linear relationship can be made between log(V) and log(L):
   **$`V = \beta L^{\alpha}`$**
   
   **$`log(V) = log({\beta}) + a*log(L)`$**

Where a = gradient and log(B) = y-intercept 

3) Following this linear model, I can find the values of a and B:

   exponent $\alpha$ = **1.515**, with a P-value of **2.3e-10**

   scaling factor $\beta$ = **1182** with a P-value of **6.4e-10**

   The P-values for both these values indicate that they are both significant as they are much smaller than 0.05

## Instructions

The homework for this Computer skills practical is divided into 5 questions for a total of 100 points (plus an optional bonus question worth 10 extra points). First, fork this repo and make sure your fork is made **Public** for marking. Answers should be added to the # INSERT ANSWERS HERE # section above in the **README.md** file of your forked repository.

Questions 1, 2 and 3 should be answered in the **README.md** file of the `logistic_growth` repo that you forked during the practical. To answer those questions here, simply include a link to your logistic_growth repo.

**Submission**: Please submit a single **PDF** file with your candidate number (and no other identifying information), and a link to your fork of the `reproducible-research_homework` repo with the completed answers. All answers should be on the `main` branch.

## Assignment questions 

1) (**10 points**) Annotate the **README.md** file in your `logistic_growth` repo with more detailed information about the analysis. Add a section on the results and include the estimates for $N_0$, $r$ and $K$ (mention which *.csv file you used).
   
2) (**10 points**) Use your estimates of $N_0$ and $r$ to calculate the population size at $t$ = 4980 min, assuming that the population grows exponentially. How does it compare to the population size predicted under logistic growth? 

3) (**20 points**) Add an R script to your repository that makes a graph comparing the exponential and logistic growth curves (using the same parameter estimates you found). Upload this graph to your repo and include it in the **README.md** file so it can be viewed in the repo homepage.
   
4) (**30 points**) Sometimes we are interested in modelling a process that involves randomness. A good example is Brownian motion. We will explore how to simulate a random process in a way that it is reproducible:

   - A script for simulating a random_walk is provided in the `question-4-code` folder of this repo. Execute the code to produce the paths of two random walks. What do you observe? (10 points)
   - Investigate the term **random seeds**. What is a random seed and how does it work? (5 points)
   - Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked `reproducible-research_homework` repo. (10 points)
   - Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the **README.md** of the fork). (5 points)

5) (**30 points**) In 2014, Cui, Schlub and Holmes published an article in the *Journal of Virology* (doi: https://doi.org/10.1128/jvi.00362-14) showing that the size of viral particles, more specifically their volume, could be predicted from their genome size (length). They found that this relationship can be modelled using an allometric equation of the form **$`V = \beta L^{\alpha}`$**, where $`V`$ is the virion volume in nm<sup>3</sup> and $`L`$ is the genome length in nucleotides.

   - Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the `question-5-data` folder). How many rows and columns does the table have? (3 points)
   - What transformation can you use to fit a linear model to the data? Apply the transformation. (3 points)
   - Find the exponent ($\alpha$) and scaling factor ($\beta$) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in **Table 2** of the paper, did you find the same values? (10 points)
   - Write the code to reproduce the figure shown below. (10 points)

  <p align="center">
     <img src="https://github.com/josegabrielnb/reproducible-research_homework/blob/main/question-5-data/allometric_scaling.png" width="600" height="500">
  </p>

  - What is the estimated volume of a 300 kb dsDNA virus? (4 points)

**Bonus** (**10 points**) Explain the difference between reproducibility and replicability in scientific research. How can git and GitHub be used to enhance the reproducibility and replicability of your work? what limitations do they have? (e.g. check the platform [protocols.io](https://www.protocols.io/)).
