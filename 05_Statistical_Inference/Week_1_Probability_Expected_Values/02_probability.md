Probability
================

## Probability

-   In these slides we will cover the basics of probability at low
    enough level to have a basic understanding for the rest of the
    series
-   For a more complete treatment see the class Mathematical
    Biostatistics Boot Camp 1
    -   Youtube:
        www.youtube.com/playlist?list=PLpl-gQkQivXhk6qSyiNj51qamjAtZISJ-
    -   Coursera: www.coursera.org/course/biostats
    -   Git: <http://github.com/bcaffo/Caffo-Coursera>

Given a random experiment (say rolling a die) a probability measure is a
population quantity that summarizes the randomness.

Specifically, probability takes a possible outcome from the expertiment
and:

-   assigns it a number between 0 and 1
-   so that the probability that something occurs is 1 (the die must be
    rolled) and
-   so that the probability of the union of any two sets of outcomes
    that have nothing in common (mutually exclusive) is the sum of their
    respective probabilities.

The Russian mathematician Kolmogorov formalized these rules.

## Rules probability must follow

-   The probability that nothing occurs is 0
-   The probability that something occurs is 1
-   The probability of something is 1 minus the probability that the
    opposite occurs
-   The probability of at least one of two (or more) things that can not
    simultaneously occur (mutually exclusive) is the sum of their
    respective probabilities
-   If an event A implies the occurrence of event B, then the
    probability of A occurring is less than the probability that B
    occurs
-   For any two events the probability that at least one occurs is the
    sum of their probabilities minus their intersection.

## Notation

-   The **sample space**, *Ω*, is the collection of possible outcomes of
    an experiment
    -   Example: die roll *Ω* = {1, 2, 3, 4, 5, 6}
-   An **event**, say *E*, is a subset of *Ω*
    -   Example: die roll is even *E* = {2, 4, 6}
-   An **elementary** or **simple** event is a particular result of an
    experiment
    -   Example: die roll is a four, *ω* = 4
-   ∅ is called the **null event** or the **empty set**

## Interpretation of set operations

Normal set operations have particular interpretations in this setting

1.  *ω* ∈ *E* implies that *E* occurs when *ω* occurs
2.  *ω* ∉ *E* implies that *E* does not occur when *ω* occurs
3.  *E* ⊂ *F* implies that the occurrence of *E* implies the occurrence
    of *F*
4.  *E* ∩ *F* implies the event that both *E* and *F* occur
5.  *E* ∪ *F* implies the event that at least one of *E* or *F* occur
6.  *E* ∩ *F* = ∅ means that *E* and *F* are **mutually exclusive**, or
    cannot both occur
7.  *E*<sup>*c*</sup> or *Ē* is the event that *E* does not occur

## Probability

A **probability measure**, *P*, is a function from the collection of
possible events so that the following hold

1.  For an event *E* ⊂ *Ω*, 0 ≤ *P*(*E*) ≤ 1
2.  *P*(*Ω*) = 1
3.  If *E*<sub>1</sub> and *E*<sub>2</sub> are mutually exclusive events
    *P*(*E*<sub>1</sub> ∪ *E*<sub>2</sub>) = *P*(*E*<sub>1</sub>) + *P*(*E*<sub>2</sub>).

Part 3 of the definition implies **finite additivity**

$$
P(\\cup\_{i=1}^n A\_i) = \\sum\_{i=1}^n P(A\_i)
$$
where the {*A*<sub>*i*</sub>} are mutually exclusive. (Note a more
general version of additivity is used in advanced classes.)

## Example consequences

-   *P*(∅) = 0
-   *P*(*E*) = 1 − *P*(*E*<sup>*c*</sup>)
-   *P*(*A* ∪ *B*) = *P*(*A*) + *P*(*B*) − *P*(*A* ∩ *B*)
-   if *A* ⊂ *B* then *P*(*A*) ≤ *P*(*B*)
-   *P*(*A*∪*B*) = 1 − *P*(*A*<sup>*c*</sup> ∩ *B*<sup>*c*</sup>)
-   *P*(*A* ∩ *B*<sup>*c*</sup>) = *P*(*A*) − *P*(*A* ∩ *B*)
-   $P(\\cup\_{i=1}^n E\_i) \\leq \\sum\_{i=1}^n P(E\_i)$
-   $P(\\cup\_{i=1}^n E\_i) \\geq \\max\_i P(E\_i)$

## Example

The National Sleep Foundation
([www.sleepfoundation.org](http://www.sleepfoundation.org/)) reports
that around 3% of the American population has sleep apnea. They also
report that around 10% of the North American and European population has
restless leg syndrome. Does this imply that 13% of people will have at
least one sleep problems of these sorts?

## Example continued

Answer: No, the events are not mutually exclusive. To elaborate let:

*A*<sub>1</sub> = {Person has sleep apnea}
*A*<sub>2</sub> = {Person has RLS}

Then
*P*(*A*<sub>1</sub> ∪ *A*<sub>2</sub>) = *P*(*A*<sub>1</sub>) + *P*(*A*<sub>2</sub>) − *P*(*A*<sub>1</sub> ∩ *A*<sub>2</sub>) = 0.13 − Probability of having both

Likely, some fraction of the population has both.

## Going further

Probability calculus is useful for understanding the rules that
probabilities must follow.

However, we need ways to model and think about probabilities for numeric
outcomes of experiments (broadly defined).

Densities and mass functions for random variables are the best starting
point for this.

Remember, everything we’re talking about up to at this point is a
population quantity not a statement about what occurs in the data.  
- We’re going with this is: use the data to estimate properties of the
population.

## Random variables

-   A **random variable** is a numerical outcome of an experiment.
-   The random variables that we study will come in two varieties,
    **discrete** or **continuous**.
-   Discrete random variable are random variables that take on only a
    countable number of possibilities and we talk about the probability
    that they take specific values
    -   *P*(*X* = *k*)
-   Continuous random variable can take any value on the real line or
    some subset of the real line and we talk about the probability that
    they line within some range
    -   *P*(*X* ∈ *A*)

## Examples of variables that can be thought of as random variables

Experiments that we use for intuition and building context

-   The (0 − 1) outcome of the flip of a coin
-   The outcome from the roll of a die

Specific instances of treating variables as if random

-   The web site traffic on a given day
-   The BMI of a subject four years after a baseline measurement
-   The hypertension status of a subject randomly drawn from a
    population
-   The number of people who click on an ad
-   Intelligence quotients for a sample of children

## PMF

A probability mass function evaluated at a value corresponds to the
probability that a random variable takes that value. To be a valid pmf a
function, *p*, must satisfy

1.  It must always be larger than or equal to 0. *p*(*x*) ≥ 0 for all
    *x*
2.  The sum of the possible values that the random variable can take has
    to add up to one. ∑<sub>*x*</sub>*p*(*x*) = 1

The sum is taken over all of the possible values for *x*.

## Example

Let *X* be the result of a coin flip where *X* = 0 represents tails and
*X* = 1 represents heads.
*p*(*x*) = (1/2)<sup>*x*</sup>(1/2)<sup>1 − *x*</sup>   for   *x* = 0, 1
Suppose that we do not know whether or not the coin is fair; Let *θ* be
the probability of a head expressed as a proportion (between 0 and 1).
*p*(*x*) = *θ*<sup>*x*</sup>(1 − *θ*)<sup>1 − *x*</sup>   for   *x* = 0, 1

## PDF

A probability density function (pdf), is a function associated with a
continuous random variable

*Areas under pdfs correspond to probabilities for that random variable*

To be a valid pdf, a function *f* must satisfy

1.  It must be larger than or equal to zero everywhere. *f*(*x*) ≥ 0 for
    all *x*
2.  The area under *f*(*x*) is one.

## Example

Suppose that the proportion of help calls that get addressed in a random
day by a help line is given by
$$
f(x) = \\left\\{\\begin{array}{ll}
    2 x & \\mbox{ for } 1 &gt; x &gt; 0 \\\\
    0                 & \\mbox{ otherwise} 
\\end{array} \\right. 
$$

Is this a mathematically valid density?

``` r
x <- c(-0.5, 0, 1, 1, 1.5); y <- c( 0, 0, 2, 0, 0)
plot(x, y, lwd = 3, frame = FALSE, type = "l")
```

<img src="02_probability_files/figure-gfm/unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

What is the probability that 75% or fewer of calls get addressed?

<img src="02_probability_files/figure-gfm/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

``` r
1.5 * .75 / 2
```

    ## [1] 0.5625

``` r
pbeta(.75, 2, 1)
```

    ## [1] 0.5625

## CDF and survival function

Certain areas are so useful, we give them names

-   The **cumulative distribution function** (CDF) of a random variable
    *X* returns the probability that the random variable is less than or
    equal to the value *x*
    *F*(*x*) = *P*(*X* ≤ *x*)

-   This definition applies regardless of whether *X* is discrete or
    continuous.

-   The **survival function** of a random variable *X* is defined as the
    probability that the random variable is greater than the value *x*
    *S*(*x*) = *P*(*X* &gt; *x*)

-   Notice that *S*(*x*) = 1 − *F*(*x*)

-   For continuous random variables, the PDF is the derivative of the
    CDF

## Example

What are the survival function and CDF from the density considered
before?

For 1 ≥ *x* ≥ 0
$$
F(x) = P(X \\leq x) = \\frac{1}{2} Base \\times Height = \\frac{1}{2} (x) \\times (2 x) = x^2
$$

*S*(*x*) = 1 − *x*<sup>2</sup>

``` r
pbeta(c(0.4, 0.5, 0.6), 2, 1)
```

    ## [1] 0.16 0.25 0.36

## Quantiles

-   The *α*<sup>*t**h*</sup> **quantile** of a distribution with
    distribution function *F* is the point *x*<sub>*α*</sub> so that
    *F*(*x*<sub>*α*</sub>) = *α*
-   A **percentile** is simply a quantile with *α* expressed as a
    percent
-   The **median** is the 50<sup>*t**h*</sup> percentile

## Example

What is the median of the distribution that we were working with before?

-   We want to solve 0.5 = *F*(*x*) = *x*<sup>2</sup>
-   Resulting in the solution

``` r
sqrt(0.5)
```

    ## [1] 0.7071068

-   Therefore, about 0.7071068 of calls being answered on a random day
    is the median.
-   R can approximate quantiles for you for common distributions

``` r
qbeta(0.5, 2, 1)
```

    ## [1] 0.7071068

## Summary

-   You might be wondering at this point “I’ve heard of a median before,
    it didn’t require integration. Where’s the data?”
-   We’re referring to are **population quantities**. Therefore, the
    median being discussed is the **population median**.
-   A probability model connects the data to the population using
    assumptions.
-   Therefore the median we’re discussing is the **estimand**, the
    sample median will be the **estimator**
