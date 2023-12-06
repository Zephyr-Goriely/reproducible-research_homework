# Reproducible research: version control and R

## Questions 1, 2, 3: 
Answered in the README.md in https://github.com/hiddenuser3/logistic_growth.git

## Question 4

1) In executing this code, two graphs are produced which seem to demonstrate the path of random motion from time 1 to 500. This motion is plotted on a two dimensional field which is represented by the x and y axes of the graph. This 'random' motion is directed by the 'random_walk' function which programms a consecutive sequence of coordinate positions such that at each next timestep, the path will progress in a random direction. This is made possible by using a 'for' loop where the 'angle' is reset with each time interval and given a new value so that the trend simulates brownian motion. Despite the functions and graphing code being the same, with different randomised walks in each dataset, the two graphs show individually unique and random motion. The legend allows for interpretation of where the path starts and finishes. This is important as without the colour spectrum representing the chronological motion, overlaps in the path could lead to confusion in direction. 
 
4) The term "random seeds" usually refers to the initial value used to initialize a pseudorandom number generator. This is an algorithm that generates a sequence of numbers that appears to be random but is actually deterministic. Given the same initial seed, a PRNG will produce the same sequence of "random" numbers. Changing the seed will result in a completely different 'randomised' behaviour that is due to a different initial value. 

5) Adjusting the 'random_walk' code to simulate reproducible brownian motion can make sure of random seeds. A random seed can be used to generate the apparent random behaviour that is observed in the plotted graphs but in a way that is reproducible due to the predetermined output. A new random seed can be generated with each use of the function 'random_walk' which has been changed to generate a 'random' sequence of motion that is asigned to a specific seed. The function achieves this by setting parameters such that each next step in the sequence will orient in a new direction and assume a new coordinate (x,y) on the plot. 'data1' and 'data2' are both defined using this function, and everytime these datasets are used, they will produce the same behaviour because their seed is set. If a new dataset was created (e.g., data3 <- random_walk(500, seed = 44)), or the original datasets are redefined (by running the object code again with new seed values) then an entirely new 'random' behaviour would be observed. In this way, random seeds can be used to establish plots of random behaviour, that can be recalled and compared.  

6) Below are images attached to show a comparison between the original random_walk code and the new brownian motion code that now uses random seeds to set predetermined brownian motion behaviours:

<img width="1260" alt="code_comparison_1" src="https://github.com/Zephyr-Goriely/reproducible-research_homework/assets/150150268/f791f61f-fb4a-49ea-b542-2af3f85d4f20">
<img width="1259" alt="code_comparison_2" src="https://github.com/Zephyr-Goriely/reproducible-research_homework/assets/150150268/bdc8486c-8c55-4576-863d-e7e6bbd8bb42">

## Question 5

1) The CSV table containing the dataset of dsDNA viruses has 13 columns and 33 rows

2) The data is currently under the relationship explained by this equation: **$`V = \beta L^{\alpha}`$**. This relationship is an exponential. By taking a **log transformation** of both sides of the equation, a linear relationship can be made between log(V) and log(L):

   **$`V = \beta L^{\alpha}`$**
   
   **$`log(V) = log({\beta}) + a*log(L)`$**

   Where a = gradient and log(B) = y-intercept 

4) Following this linear model, I can find the values of a and B:

   exponent $\alpha$ = **1.515**, with a P-value of **2.3e-10**

   scaling factor $\beta$ = **1182** with a P-value of **6.4e-10**

   The P-values for both these values indicate that they are both significant as they are much smaller than 0.05

5) Comparison with the values shown in table 2 from the paper:

   exponent $\alpha$ = **1.43(1.26-1.6)**

   scaling factor $\beta$ = **2075(1185-3571)**

The exponent value finds the same value in comparison to the paper (falling within the error margins). The scaling factor falls just short of the lower error margin from the paper. However, these values are very similar.

5) The data to plot the graph is shown below:

```{r}
#Loading in the dataset under the name 'virus_data'
virus_data <- read_csv("question-5-data/Cui_etal2014.csv")

#Installing and loading in the necessary packages
install.packages("dplyr")
install.packages("ggplot2")
install.packages("janitor")

library(dplyr)
library(ggplot2)
library(janitor)

# Investigating the virus dataset
summary(virus_data)

# Defining functions in order to clean up the dataset for later use. The first function is set to rename the column names so they can be used in computer readable language (lower and snake case). The second function is set to remove all empty columns and rows:
clean_column_names <- function(virus_data) {
  virus_data %>%
    clean_names()
}

remove_empty_columns_rows <- function(virus_data) {
  virus_data %>%
    remove_empty(c("rows", "cols"))
}
# Creating a new dataset with the cleaned data
virus_clean <- virus_data %>%
  clean_column_names() %>%
  remove_empty_columns_rows()

head(virus_clean)
colnames(virus_clean)
# Creating a data subset so that I can mutate the subject variables through a logarithmic transformation. This is done so that a linear model can be ran:

data_subset1 <- virus_clean %>% mutate(log_V = log(virion_volume_nm_nm_nm)) %>% mutate(log_L = log(genome_length_kb))
linear_model <- lm(data = data_subset1, log_V ~ log_L)
summary(linear_model)

# Below is the code to produce a graph investigating the linear relationship between the log transformed variables to match the graph shown in the intructions of the exercise:
ggplot(data = data_subset1, aes(x = log_L, y = log_V)) +
  geom_point() +
  geom_smooth(method = lm, colour = "blue") +
  labs(x = "log [Genome length(kb)]", 
       y = "log [Virion volume (nm3)]") +
  theme_bw()
```
![graph_plot](https://github.com/Zephyr-Goriely/reproducible-research_homework/assets/150150268/85696c77-cf7f-4bf2-86e4-8ecb4b46243a)

6) The estimated volume of a 300kb dsDNA virus can be calculated following the equation above
    **$`V = \beta L^{\alpha}`$** using the estimated values of $\beta$ and $\alpha$:

    **$`V = 1182*300^{1.515} = 6690463nm^3`$**

## Bonus Question

Reproducability in the context of scientific research refers to the ability of an experimental analysis to produce consistent results when repeated under the same conditions (using the same data, methods and code). The 'reproducible' work should be achieved by repetitions, independent of its completion by the original author or different researchers. Reproducible work is exemplified by a detailed annotation of the code and data used such that others can indpenently reproduce the same results with no need for further assistance. 

Repeatability is a similar but distinctly different concept and refers to the ability of consistent results to be obtained when researchers repeat an entire study. Repeating an entire study comprises the use of the same methods, design features and procedure framework of one study by independent work of different researchers. Differentiation from reproducability arises due to the fact that repeatability does not refer to the use of the same dataset, instruments or experimental conditions but still expects consistent results. When different conditions are applied to a set methodology in a study, consistent results would be expected if the original study is repeatable. This is because repeatability relies on the notion that when performed properly, the tested principles should always behave the same way.

Git and GitHub are useful tools in ensuring that the reproducability and repeatability of work is enhanced. There are multiple aspects that allow this:
- Code sharing: Perhaps the most obvious use of GitHub is its role as a platform which hosts Git repositories. Researchers can make use of these public access repositories that are kept on a single online location to document their work, code and data so that collaborators can easily find and reproduce their work.
- Discussion: GitHub serves a further purpose of problem resolution and discussion by providing researchers with a way of commenting on work in GitHub, promoting the flow of information and communcation between researchers.
- Version control: By setting a platform where commits and branches can be tagged to specific versions, GitHub enables collaborators and other researchers to track the change in code and understand the progression of a project. This enhances the transparency of work and can provide the answer to any confusions that may arise when others investigate the public project.
- Fork function: The ability to fork and clone Git repositories allows researchers to obtain a full copy of all of the documentation of a project. This allows them to efficinently replicate the work of another without affecting the original work.

While the use of git and GitHub enhances reproducability and repeatability, there are some limitations that may deter researchers from using the platform. Perhaps the largest limitation to consider is the fact that as work is submitted on this platform, it is openly accessible to the entire internet. Therefore, this may be problematic when data is sensitive, violating privacy concerns. Researchers must therefore first consider anonymysing their datasets before they can produce their work on GitHub. Additionally, without the proper protection, projects could be misused or manipulated without the owners consent. This may lead to further issues in analysis. Due to the restrictions of being an online platform, GitHub has further limitations such as issues in storing large datasets and unless researchers are familiar with the program, it may be difficult to first navigate. 

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
