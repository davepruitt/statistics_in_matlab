# Part 6: Functions to compute central tendency and variance
  
## 6.1 Introduction
  

We will cover the following functions in this section:

  

Mean: `mean` / `nanmean`

Median: `median` / `nanmedian`

Mode: `mode`

Standard Deviation: `std` / `nanstd`

Standard error of the mean: no pre-built function exists

95% confidence interval: no pre-built function exists

Quantile: `quantile`

  
## 6.2 Measures of central tendency
  

Let's generate some random data:

```matlab:Code
%This just makes sure that the example is repeatable
rng('default');
rng(1);

%Generate random data
x = randi([1 10], 10, 1)
```

```text:Output
x = 10x1    
     5
     8
     1
     4
     2
     1
     2
     4
     4
     6

```

To calculate the mean of the data:

```matlab:Code
x_mean = mean(x)
```

```text:Output
x_mean = 
                       3.7

```

To calculate the median:

```matlab:Code
x_median = median(x)
```

```text:Output
x_median = 
     4

```

To calculate the mode:

```matlab:Code
x_mode = mode(x)
```

```text:Output
x_mode = 
     4

```

But what if we have missing data points? I usually represent missing data points with `NaN`. Let's add some `NaN` values to our imaginary data:

```matlab:Code
x = [x; nan(5, 1)];
x = x(randperm(length(x)))
```

```text:Output
x = 15x1    
     2
     4
     6
     1
   NaN
     2
     5
     4
     1
     8

```

Now that we have some `NaN` values interspersed in our data, the `mean` and `median` functions will not work properly. Look at what happens:

```matlab:Code
x_mean = mean(x)
```

```text:Output
x_mean = 
   NaN

```

```matlab:Code
x_median = median(x)
```

```text:Output
x_median = 
   NaN

```

Obviously the correct answer is not `NaN`, so we need to properly account for the `NaN` values in our data set. Fortunately, the `nanmean` and `nanmedian` functions do nicely:

```matlab:Code
x_mean = nanmean(x)
```

```text:Output
x_mean = 
                       3.7

```

```matlab:Code
x_median = nanmedian(x)
```

```text:Output
x_median = 
     4

```

And now it has properly calculated the mean and median for our data set.

As a rule of thumb, I just *always* use `nanmean` and `nanmedian`. I pretty much never use `mean` and `median`.

  
## 6.3 Measures of variability
  

Matlab has the `std` function which computes "standard deviation":

```matlab:Code
%Create our imaginary data
x = randi([1 10], 10, 1)
```

```text:Output
x = 10x1    
     9
     1
     1
     2
     9
     1
     5
    10
     6
     7

```

```matlab:Code

%Standard deviation
x_std_dev = std(x)
```

```text:Output
x_std_dev = 
          3.63470921960906

```

This is useful, but in Neuroscience most people report "standard error of the mean" in their papers. Here is how we can computer the standard error of the mean:

```matlab:Code
%Standard error of the mean
x_std_err = std(x) / sqrt(length(x))
```

```text:Output
x_std_err = 
          1.14939597663778

```

Once again, these functions do not play nicely with data sets that have missing values (`NaN` values), so here is a variation that works well with `NaN` values:

```matlab:Code
%Once again, add some NaN values to the data set
x = [x; nan(5, 1)];
x = x(randperm(length(x)))
```

```text:Output
x = 15x1    
     2
     7
   NaN
    10
   NaN
   NaN
     9
   NaN
     1
     5

```

```matlab:Code

%Now do standard deviation / standard error of the mean
x_std_dev = std(x)
```

```text:Output
x_std_dev = 
   NaN

```

```matlab:Code
x_std_err = std(x) / sqrt(length(x))
```

```text:Output
x_std_err = 
   NaN

```

```matlab:Code

%Now let's use the functions that properly handle NaN values
x_std_dev = nanstd(x)
```

```text:Output
x_std_dev = 
          3.63470921960906

```

```matlab:Code
x_std_err = nanstd(x) / sqrt(length(x(~isnan(x))))
```

```text:Output
x_std_err = 
          1.14939597663778

```

  
## 6.4 Calculating the 95% Confidence Interval
  

I use the following function to calculate the 95% confidence interval:

`function ci = simple_ci (X, alpha)`

`    if (nargin < 2)`

`        alpha = 0.05;`

`    end`

`    if (nargin < 1)`

`        error('simple_ci requires single column data input.');`

`    end`

`    [h, p, ci] = ttest(X, 0, alpha);`

`    ci = nanmean(X, 1) - ci(1, :);`

`end`

Example of usage:

```matlab:Code
x_confidence_interval = simple_ci(x)
```

```text:Output
x_confidence_interval = 
          2.60011434144259

```

  
## 6.5 Calculating Quantiles
  

This allows us to say "X" percent of my data is above or below a certain value.

Let's take a look at the following example data:

```matlab:Code
x = [1 6 4 9 5 3 3 10 2 2];
```

We can use the `quantile` function:

```matlab:Code
quantile(x, 0.25)
```

```text:Output
ans = 
     2

```

In this example, 25% of the data is less than or equal to 2.

```matlab:Code
quantile(x, 0.5)
```

```text:Output
ans = 
                       3.5

```

50% of the data is less than or equal to 3.5 (thus 3.5 is also the median).

```matlab:Code
quantile(x, 0.75)
```

```text:Output
ans = 
     6

```

75% of the data is less than or equal to 6.

`quantile` is capable of handling `NaN` values.

## 6.6 Appendix
  

The simple_ci function:

```matlab:Code
function ci = simple_ci (X, alpha)
if (nargin < 2)
    alpha = 0.05;
end
if (nargin < 1)
    error('simple_ci requires single column data input.');
end
[h, p, ci] = ttest(X, 0, alpha);
ci = nanmean(X, 1) - ci(1, :);
end
```
