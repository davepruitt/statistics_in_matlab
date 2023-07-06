# Part 4: Non-parametric replacements for parametric tests
  
## 4.1 Introduction
  

|               Name of test              | Equivalent parametric test |     Matlab function     |
| --------------------------------------- | -------------------------- | ----------------------- |
| Mann-Whitney U-test / Wilcoxon rank-sum | Unpaired t-test            | ranksum                 |
| Wilcoxon signed-rank                    | Paired t-test              | signrank                |
| Kruskal-Wallis                          | One-way ANOVA              | kruskalwallis           |
| Friedman                                | 2-way ANOVA or RM-ANOVA    | friedman                |

When you should use a non-parametric test:
1. If you are dealing with data that is ordinal/categorical, i.e. not continuous numerical data.
2. If you are dealing with numerical data, but it does not satisfy the conditions of using a parametric test (typically that means the data doesn't fit well with a normal distribution).
  
## 4.2 Wilcoxon rank-sum (equivalent to an unpaired t-test)
  

Usage of this function is equivalent to the `ttest2` function, except for one *small but important detail*. It returns the result in the order `[p, h]` instead of the order `[h, p]`.

Example:

```matlab:Code
g1_data = [0.25 1 1.3 1.6 2.0 2.75];
g2_data = [0 0 0 0 0 1.25 3.75];

[h, p] = ttest2(g1_data, g2_data)
```

```text:Output
h = 
     0

p = 
         0.272147797306786

```

```matlab:Code
[p, h] = ranksum(g1_data, g2_data)
```

```text:Output
p = 
        0.0664335664335664

h = 
   0

```

  
## 4.3 Wilcoxon signed-rank test (equivalent to a paired t-test)
  

Usage of this function is exactly the same as using the `ttest` function, except the order of the returned result is flipped (like the `ranksum` function).

Example:

```matlab:Code
[p, h] = signrank(g2_data)
```

```text:Output
p = 
                       0.5

h = 
   0

```

  
## 4.4 Kruskal-Wallis (equivalent to a 1-way ANOVA)
  

Usage of the function `kruskalwallis` is identical to the usage of `anova1` in Matlab, and thus it also comes with the same limitations of `anova1` (you must have a balanced design to use `kruskalwallis`).

Example:

```matlab:Code
map_data = [1 2 3 2 4 8 9 7 10 10 8 8 9 9 10 1 3 3 2 2]';
groups = [1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4]';

[p, tbl, stats] = kruskalwallis(map_data, groups, 'off')
```

```text:Output
p = 
       0.00219623483674327

```

| |1|2|3|4|5|6|
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|1|'Source'|'SS'|'df'|'MS'|'Chi-sq'|'Prob>Chi-sq'|
|2|'Groups'|500.5|3|166.833333333333|14.5963161933998|0.00219623483674327|
|3|'Error'|151|16|9.4375|[ ]|[ ]|
|4|'Total'|651.5|19|[ ]|[ ]|[ ]|

```text:Output
stats = 
       gnames: {4x1 cell}
            n: [5 5 5 5]
       source: 'kruskalwallis'
    meanranks: [5.7 15.6 15.4 5.3]
         sumt: 162

```

**How to report a Kruskal Wallis test in your paper:**

*"We found that there was a significant effect of VNS amplitude on forelimb motor map area (Kruskal-Wallis, X^2 = 14.59, p = 0.0022)."*

  
## 4.5 Friedman (equivalent to a 2-way ANOVA)
  

This works *only* on balanced designs, and thus has the same limitations as the `anova2` function.

Example:

```matlab:Code
%Some mapping data.
%First 3 rows are "No Training"
%Second 3 rows are "Training"
%First column is "No TBI"
%Second column is "TBI"
map_data = [6 0; 8 0; 3 0; 10 0; 5 1; 9 0.5];

%"3" is the number of samples per group. This MUST be a multiple of the
%number of rows in your matrix.
[p, tbl, stats] = friedman(map_data, 3, 'off')
```

```text:Output
p = 
       0.00423123289975815

```

| |1|2|3|4|5|6|
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|1|'Source'|'SS'|'df'|'MS'|'Chi-sq'|'Prob>Chi-sq'|
|2|'Columns'|27|1|27|8.18181818181818|0.00423123289975815|
|3|'Interaction'|0|1|0|[ ]|[ ]|
|4|'Error'|6|8|0.75|[ ]|[ ]|
|5|'Total'|33|11|[ ]|[ ]|[ ]|

```text:Output
stats = 
       source: 'friedman'
            n: 2
    meanranks: [5 2]
        sigma: 1.81659021245849

```
