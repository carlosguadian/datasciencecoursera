Structure of a Data Analysis 1
================

-   [Steps in a data analysis](#steps-in-a-data-analysis)
-   [Steps in a data analysis](#steps-in-a-data-analysis-1)
-   [The key challenge in data
    analysis](#the-key-challenge-in-data-analysis)
-   [Defining a question](#defining-a-question)
-   [An example](#an-example)
-   [Define the ideal data set](#define-the-ideal-data-set)
-   [Our example](#our-example)
-   [Determine what data you can
    access](#determine-what-data-you-can-access)
-   [Back to our example](#back-to-our-example)
-   [A possible solution](#a-possible-solution)
-   [Obtain the data](#obtain-the-data)
-   [Our data set](#our-data-set)
-   [Clean the data](#clean-the-data)
-   [Our cleaned data set](#our-cleaned-data-set)

## Steps in a data analysis

-   Define the question
-   Define the ideal data set
-   Determine what data you can access
-   Obtain the data
-   Clean the data
-   Exploratory data analysis
-   Statistical prediction/modeling
-   Interpret results
-   Challenge results
-   Synthesize/write up results
-   Create reproducible code

## Steps in a data analysis

-   *Define the question*
-   *Define the ideal data set*
-   *Determine what data you can access*
-   *Obtain the data*
-   *Clean the data*
-   Exploratory data analysis
-   Statistical prediction/modeling
-   Interpret results
-   Challenge results
-   Synthesize/write up results
-   Create reproducible code

## The key challenge in data analysis

“Ask yourselves, what problem have you solved, ever, that was worth
solving, where you knew all of the given information in advance? Where
you didn’t have a surplus of information and have to filter it out, or
you had insufficient information and have to go find some?”

![Dan Myer, Mathematics
Educator](https://github.com/DataScienceSpecialization/courses/raw/master/assets/img/meyer.jpg)

[Dan Myer, Mathematics
Educator](http://www.ted.com/talks/dan_meyer_math_curriculum_makeover.html)

## Defining a question

![Defining
question](https://github.com/DataScienceSpecialization/courses/raw/master/assets/img/stat-projects.jpg)

1.  Statistical methods development
2.  [Danger zone!!!](http://www.drewconway.com/zia/?p=2378)
3.  Proper data analysis

## An example

**Start with a general question**

Can I automatically detect emails that are SPAM that are not?

**Make it concrete**

Can I use quantitative characteristics of the emails to classify them as
SPAM/HAM?

## Define the ideal data set

-   The data set may depend on your goal
    -   Descriptive - a whole population
    -   Exploratory - a random sample with many variables measured
    -   Inferential - the right population, randomly sampled
    -   Predictive - a training and test data set from the same
        population
    -   Causal - data from a randomized study
    -   Mechanistic - data about all components of the system

## Our example

![Google Data
Centers](https://github.com/DataScienceSpecialization/courses/raw/master/assets/img/datacenter.png)

<http://www.google.com/about/datacenters/inside/>

## Determine what data you can access

-   Sometimes you can find data free on the web
-   Other times you may need to buy the data
-   Be sure to respect the terms of use
-   If the data don’t exist, you may need to generate it yourself

## Back to our example

![Data Center
Security](https://github.com/DataScienceSpecialization/courses/raw/master/assets/img/security.png)

## A possible solution

![SpamBase](https://github.com/DataScienceSpecialization/courses/raw/master/assets/img/uci.png)

<http://archive.ics.uci.edu/ml/datasets/Spambase>

## Obtain the data

-   Try to obtain the raw data
-   Be sure to reference the source
-   Polite emails go a long way
-   If you will load the data from an internet source, record the url
    and time accessed

## Our data set

![Dataset](https://github.com/DataScienceSpecialization/courses/raw/master/assets/img/spamR.png)

<http://search.r-project.org/library/kernlab/html/spam.html>

## Clean the data

-   Raw data often needs to be processed
-   If it is pre-processed, make sure you understand how
-   Understand the source of the data (census, sample, convenience
    sample, etc.)
-   May need reformating, subsampling - record these steps
-   **Determine if the data are good enough** - if not, quit or change
    data

## Our cleaned data set

``` r
# If it isn't installed, install the kernlab package with install.packages()
library(kernlab)
data(spam)
str(spam[, 1:5])
```

    ## 'data.frame':    4601 obs. of  5 variables:
    ##  $ make   : num  0 0.21 0.06 0 0 0 0 0 0.15 0.06 ...
    ##  $ address: num  0.64 0.28 0 0 0 0 0 0 0 0.12 ...
    ##  $ all    : num  0.64 0.5 0.71 0 0 0 0 0 0.46 0.77 ...
    ##  $ num3d  : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ our    : num  0.32 0.14 1.23 0.63 0.63 1.85 1.92 1.88 0.61 0.19 ...

<http://search.r-project.org/library/kernlab/html/spam.html>
