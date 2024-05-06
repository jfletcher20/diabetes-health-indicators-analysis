Table for HighChol :

      0   1
  0 614 386
  1 330 670

H0: The HighChol is independent of Diabetes_binary
H1: The HighChol is not independent of Diabetes_binary


        Pearson's Chi-squared test with Yates' continuity correction

data:  tab
X-squared = 160.68, df = 1, p-value < 2.2e-16


Reject H0: There is a significant association between HighChol and Diabetes_binary

Table for CholCheck :

      0   1
  0  44 956
  1   7 993

H0: The CholCheck is independent of Diabetes_binary
H1: The CholCheck is not independent of Diabetes_binary


        Pearson's Chi-squared test with Yates' continuity correction

data:  tab
X-squared = 26.077, df = 1, p-value = 3.281e-07


Reject H0: There is a significant association between CholCheck and Diabetes_binary

Table for BMI_Group :

    Underweight Healthy weight Overweight Obesity Severe obesity
  0          15            296        374     278             37
  1           4            120        296     454            126

H0: The BMI_Group is independent of Diabetes_binary
H1: The BMI_Group is not independent of Diabetes_binary


        Pearson's Chi-squared test

data:  tab
X-squared = 180.82, df = 4, p-value < 2.2e-16


Reject H0: There is a significant association between BMI_Group and Diabetes_binary

Table for HvyAlcoholConsump :

      0   1
  0 937  63
  1 973  27

H0: The HvyAlcoholConsump is independent of Diabetes_binary
H1: The HvyAlcoholConsump is not independent of Diabetes_binary


        Pearson's Chi-squared test with Yates' continuity correction

data:  tab
X-squared = 14.252, df = 1, p-value = 0.0001599


Reject H0: There is a significant association between HvyAlcoholConsump and Diabetes_binary

Table for AnyHealthcare :

      0   1
  0  45 955
  1  39 961

H0: The AnyHealthcare is independent of Diabetes_binary
H1: The AnyHealthcare is not independent of Diabetes_binary


        Pearson's Chi-squared test with Yates' continuity correction

data:  tab
X-squared = 0.31067, df = 1, p-value = 0.5773


Fail to reject H0: There is no significant association between AnyHealthcare and Diabetes_binary

Table for NoDocbcCost :

      0   1
  0 915  85
  1 889 111

H0: The NoDocbcCost is independent of Diabetes_binary
H1: The NoDocbcCost is not independent of Diabetes_binary


        Pearson's Chi-squared test with Yates' continuity correction

data:  tab
X-squared = 3.5352, df = 1, p-value = 0.06008


Fail to reject H0: There is no significant association between NoDocbcCost and Diabetes_binary

Table for Sex :

      0   1
  0 561 439
  1 499 501

H0: The Sex is independent of Diabetes_binary
H1: The Sex is not independent of Diabetes_binary


        Pearson's Chi-squared test with Yates' continuity correction

data:  tab
X-squared = 7.4689, df = 1, p-value = 0.006277


Reject H0: There is a significant association between Sex and Diabetes_binary

Table for Age_Group :

    18-34 35-54 55-69 70-80+
  0   104   216   334    269
  1    13    83   381    417

H0: The Age_Group is independent of Diabetes_binary
H1: The Age_Group is not independent of Diabetes_binary


        Pearson's Chi-squared test

data:  tab
X-squared = 164.54, df = 3, p-value < 2.2e-16


Reject H0: There is a significant association between Age_Group and Diabetes_binary

Table for Education_Group :

      1   2   3
  0   9 263 728
  1  41 375 584

H0: The Education_Group is independent of Diabetes_binary
H1: The Education_Group is not independent of Diabetes_binary


        Pearson's Chi-squared test

data:  tab
X-squared = 55.946, df = 2, p-value = 7.102e-13


Reject H0: There is a significant association between Education_Group and Diabetes_binary

Table for Income :

      1   2   3   4   5   6   7   8
  0  37  33  64  83  96 155 160 372
  1  56  76 104 121 136 153 165 189

H0: The Income is independent of Diabetes_binary
H1: The Income is not independent of Diabetes_binary


        Pearson's Chi-squared test

data:  tab
X-squared = 104.13, df = 7, p-value < 2.2e-16


Reject H0: There is a significant association between Income and Diabetes_binary



Shapiro-Wilk test for normality for BMI :
Diabetic Group:

        Shapiro-Wilk normality test

data:  data[[var]][data$Diabetes_binary == 1]
W = 0.91083, p-value < 2.2e-16


Non-Diabetic Group:

        Shapiro-Wilk normality test

data:  data[[var]][data$Diabetes_binary == 0]
W = 0.95053, p-value < 2.2e-16


F-test for equality of variances for BMI :

        F test to compare two variances

data:  data[[var]] by data$Diabetes_binary
F = 0.55881, num df = 999, denom df = 999, p-value < 2.2e-16
alternative hypothesis: true ratio of variances is not equal to 1
95 percent confidence interval:
 0.4935938 0.6326368
sample estimates:
ratio of variances
         0.5588073


Levene's test for BMI :
Levene's Test for Homogeneity of Variance (center = median)
        Df F value    Pr(>F)
group    1  38.322 7.257e-10 ***
      1998
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Bartlett's test for BMI :

        Bartlett test of homogeneity of variances

data:  data[[var]] by data$Diabetes_binary
Bartlett's K-squared = 83.373, df = 1, p-value < 2.2e-16

At least one group does not follow a normal distribution.
Performing nonparametric Mann-Whitney U test (Wilcoxon rank sum test)...
Wilcoxon rank sum test for BMI :

        Wilcoxon rank sum test with continuity correction

data:  BMI by Diabetes_binary
W = 318574, p-value < 2.2e-16
alternative hypothesis: true location shift is not equal to 0


Reject H0: There is a significant difference in  BMI  between diabetic and non-diabetic groups.


Shapiro-Wilk test for normality for Age :
Diabetic Group:

        Shapiro-Wilk normality test

data:  data[[var]][data$Diabetes_binary == 1]
W = 0.95317, p-value < 2.2e-16


Non-Diabetic Group:

        Shapiro-Wilk normality test

data:  data[[var]][data$Diabetes_binary == 0]
W = 0.96579, p-value = 1.407e-14


F-test for equality of variances for Age :

        F test to compare two variances

data:  data[[var]] by data$Diabetes_binary
F = 1.779, num df = 999, denom df = 999, p-value < 2.2e-16
alternative hypothesis: true ratio of variances is not equal to 1
95 percent confidence interval:
 1.571384 2.014035
sample estimates:
ratio of variances
          1.778995


Levene's test for Age :
Levene's Test for Homogeneity of Variance (center = median)
        Df F value    Pr(>F)
group    1  85.469 < 2.2e-16 ***
      1998
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Bartlett's test for Age :

        Bartlett test of homogeneity of variances

data:  data[[var]] by data$Diabetes_binary
Bartlett's K-squared = 81.713, df = 1, p-value < 2.2e-16

At least one group does not follow a normal distribution.
Performing nonparametric Mann-Whitney U test (Wilcoxon rank sum test)...
Wilcoxon rank sum test for Age :

        Wilcoxon rank sum test with continuity correction

data:  Age by Diabetes_binary
W = 352645, p-value < 2.2e-16
alternative hypothesis: true location shift is not equal to 0


Reject H0: There is a significant difference in  Age  between diabetic and non-diabetic groups.
Median for BMI in Diabetic group: 31 
Median for BMI in Non-Diabetic group: 27

Median for Age in Diabetic group: 10
Median for Age in Non-Diabetic group: 8