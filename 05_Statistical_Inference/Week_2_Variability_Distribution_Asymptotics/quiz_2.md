Quiz 2
================

## 1

What is the variance of the distribution of the average an IID draw of n
observations from a population with mean *μ* and variance
*σ*<sup>2</sup>

The average of random samples from a population is itself a random
variable having a distribution. This distribution is centered around the
poplulation mean. The variance of the sample mean is σ2/n.

`Var(X¯)=σ2/n`

## 2

Suppose that diastolic blood pressures (DBPs) for men aged 35-44 are
normally distributed with a mean of 80 (mm Hg) and a standard deviation
of 10. About what is the probability that a random 35-44 year old has a
DBP less than 70?

Given that DBPs is normally distributed, N(80,10^2) . That probability
that a random 35-40 year old has a DBP less than 70 is

``` r
pnorm(70, mean = 80, sd = 10)
```

    ## [1] 0.1586553

## 3

Brain volume for adult women is normally distributed with a mean of
about 1,100 cc for women with a standard deviation of 75 cc. What brain
volume represents the 95th percentile?

Brain volume for adult women is N(1100,75^2) . We use qnorm to calculate
the 95th percentile.

``` r
qnorm(0.95, mean = 1100, sd = 75)
```

    ## [1] 1223.364

This could also have been calculated by shifting and scaling normals.

We can transform normal random variables to standard normals and vice
versa. If X \~ N(μ,σ2) then: Z = (X- μ) / σ \~ N (0,1) . If Z is
standard normal, then X= μ + σ\*Z \~ N(μ,σ2)

In this case, the answer is μ + σ\* (1.645) as 1.645 is 95th quantile of
standard normal.

``` r
1100 + 75* 1.645 
```

    ## [1] 1223.375

## 4

Refer to the previous question. Brain volume for adult women is about
1,100 cc for women with a standard deviation of 75 cc. Consider the
sample mean of 100 random adult women from this population. What is the
95th percentile of the distribution of that sample mean?

Since brain volume is X \~ N(1100,75^2) , The distribution of the sample
mean is \~ N (1100, 75^2/100)

``` r
qnorm(0.95, mean = 1100, sd = 75/sqrt(100))
```

    ## [1] 1112.336

## 5

You flip a fair coin 5 times, about what’s the probability of getting 4
or 5 heads?

The flip of a fair coin is binomial distribution with Probability=0.5

``` r
pbinom(3, size = 5, prob = 0.5, lower.tail = FALSE)
```

    ## [1] 0.1875

Or

``` r
round (pbinom(3 , prob = 0.5, size =5, lower.tail= FALSE ) * 100,1) 
```

    ## [1] 18.7

## 6

The respiratory disturbance index (RDI), a measure of sleep disturbance,
for a specific population has a mean of 15 (sleep events per hour) and a
standard deviation of 10. They are not normally distributed. Give your
best estimate of the probability that a sample mean RDI of 100 people is
between 14 and 16 events per hour?

The standard error of the mean is $10 / \\sqrt{100} = 1$. Thus between
14 and 16 is with one standard deviation of the mean of the distribution
of the sample mean. Thus it should be about 68%.

``` r
pnorm(16, mean = 15, sd = 1) - pnorm(14, mean = 15, sd = 1)
```

    ## [1] 0.6826895

## 7

Consider a standard uniform density. The mean for this density is .5 and
the variance is 1 / 12. You sample 1,000 observations from this
distribution and take the sample mean, what value would you expect it to
be near?

`Via the LLN it should be near .5. The sample mean would be near the popular mean of standard uniform density.`

## 8

The number of people showing up at a bus stop is assumed to be Poisson
with a mean of 5 5 people per hour. You watch the bus stop for 3 hours.
About what’s the probability of viewing 10 or fewer people?

The poission distribution is useful for rates, counts that occur over
units of time , if X \~ Poisson (λt) is the expected count per unit of
time and t is the monitoring time.

``` r
ppois(10, lambda = 5*3)
```

    ## [1] 0.1184644
