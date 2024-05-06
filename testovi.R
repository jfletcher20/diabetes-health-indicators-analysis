install.packages("car")
require("car")

data <- read.csv(file.choose())

data$Diabetes_binary <- as.factor(data$Diabetes_binary)

data$BMI_Group <- cut(data$BMI, breaks = c(0, 18.5, 24.9, 29.9, 39.9, Inf),
                      labels = c("Underweight", "Healthy weight", "Overweight", "Obesity", "Severe obesity"))
data$Age_Group <- cut(data$Age, breaks = c(seq(0, 13, by = 3)), labels = c("18-34", "35-54", "55-69", "70-80+"))
data$Education_Group <- cut(data$Education, breaks = c(seq(0, 6, by = 2)), labels = FALSE)

vars <- c("HighChol", "CholCheck", "BMI_Group", "HvyAlcoholConsump", "AnyHealthcare", "NoDocbcCost",
          "Sex", "Age_Group", "Education_Group", "Income")

for (var in vars) {
  tab <- table(data$Diabetes_binary, data[[var]])
  cat("Table for", var, ":\n")
  print(tab)
  barplot(tab, beside = TRUE, legend = TRUE, main = paste("Barplot for", var))
  
  c_test <- chisq.test(tab, correct = TRUE)
  cat("\nH0: The", var, "is independent of Diabetes_binary\n")
  cat("H1: The", var, "is not independent of Diabetes_binary\n\n")
  print(c_test)
  
  p_value <- c_test$p.value
  
  if (p_value <= 0.01) {
    cat("\nReject H0: There is a significant association between", var, "and Diabetes_binary\n\n")
  } else {
    cat("\nFail to reject H0: There is no significant association between", var, "and Diabetes_binary\n\n")
  }
}

vars_to_test <- c("BMI", "Age")

for (var in vars_to_test) { # nolint
  sw_test_diabetic <- shapiro.test(data[[var]][data$Diabetes_binary == 1])
  sw_test_nondiabetic <- shapiro.test(data[[var]][data$Diabetes_binary == 0])
  
  cat("\n\nShapiro-Wilk test for normality for", var, ":\n")
  cat("Diabetic Group:\n")
  print(sw_test_diabetic)
  cat("\nNon-Diabetic Group:\n")
  print(sw_test_nondiabetic)
  
  f_test <- var.test(data[[var]] ~ data$Diabetes_binary)
  
  cat("\nF-test for equality of variances for", var, ":\n")
  print(f_test)
  
  levene_test <- leveneTest(data[[var]], data$Diabetes_binary)
  
  cat("\nLevene's test for", var, ":\n")
  print(levene_test)
  
  bartlett_test <- bartlett.test(data[[var]] ~ data$Diabetes_binary)
  
  cat("\nBartlett's test for", var, ":\n")
  print(bartlett_test)


  if (sw_test_diabetic$p.value > 0.01 && sw_test_nondiabetic$p.value > 0.01) {
    cat("Both groups follow a normal distribution.\n")
    
    if (f_test$p.value > 0.01 && levene_test$p.value && bartlett_test$p.value) {
      cat("Variances of both groups are equal.\n")
      cat("Performing parametric two-sample t-test...\n")
      
      t_test <- t.test(data[[var]] ~ data$Diabetes_binary, conf.level = 0.99)
      print(t_test)
  
      if (t_test$p.value <= 0.01) {
        cat("\nReject H0: There is a significant difference in ", var, " between diabetic and non-diabetic groups.\n")
      } else {
        cat("\nFail to reject H0: There is no significant difference in ", var, " between diabetic and non-diabetic groups.\n")
      }
      
    } else {
      cat("Variances of both groups are not equal.\n")
      cat("Performing nonparametric Mann-Whitney U test (Wilcoxon rank sum test)...\n")
      
      wilcox_test <- wilcox.test(as.formula(paste(var, "~ Diabetes_binary")), data = data)
      
      cat("Wilcoxon rank sum test for", var, ":\n")
      print(wilcox_test)
      
      if (wilcox_test$p.value <= 0.01) {
        cat("\nReject H0: There is a significant difference in ", var, " between diabetic and non-diabetic groups.\n")
      } else {
        cat("\nFail to reject H0: There is no significant difference in ", var, " between diabetic and non-diabetic groups.\n")
      }
      
    }
  } else {
    cat("At least one group does not follow a normal distribution.\n")
    cat("Performing nonparametric Mann-Whitney U test (Wilcoxon rank sum test)...\n")
    
    wilcox_test <- wilcox.test(as.formula(paste(var, "~ Diabetes_binary")), data = data)
    
    cat("Wilcoxon rank sum test for", var, ":\n")
    print(wilcox_test)
  
    if (wilcox_test$p.value <= 0.01) {
      cat("\nReject H0: There is a significant difference in ", var, " between diabetic and non-diabetic groups.\n")
    } else {
      cat("\nFail to reject H0: There is no significant difference in ", var, " between diabetic and non-diabetic groups.\n")
    }
    
    
  }
}

for (var in vars_to_test) {
  median_diabetic <- median(data[[var]][data$Diabetes_binary == 1])
  median_nondiabetic <- median(data[[var]][data$Diabetes_binary == 0])
  
  cat("Median for", var, "in Diabetic group:", median_diabetic, "\n")
  cat("Median for", var, "in Non-Diabetic group:", median_nondiabetic, "\n\n")
}

vars_to_plot <- c("BMI", "Age")

par(mfrow = c(1, length(vars_to_plot)))

for (var in vars_to_plot) {
  boxplot(data[[var]] ~ data$Diabetes_binary,
          xlab = "Diabetes Status",
          ylab = var,
          main = paste("Boxplot of", var, "by Diabetes Status"),
          col = c("lightblue", "lightgreen"),
          names = c("Non-Diabetic", "Diabetic"))
}

par(mfrow = c(1, 1))


# Deskriptivna statistika - numericka varijabla (BMI)
median_bmi <- median(data$BMI)
print(median_bmi)

mean_bmi <- mean(data$BMI)
print(mean_bmi)

standard_deviation <- sd(data$BMI)
print(standard_deviation)

variance <- var(data$BMI)
print(variance)

quantiles <- quantile(data$BMI, probs = c(0.25, 0.5, 0.75))
print(quantiles)

correlation <- cor(data$PhysHlth, data$BMI)
print(correlation)

plot(data$PhysHlth, data$BMI,
     xlab = "PhysHlth",
     ylab = "BMI",
     main = "Korelacija između PhysHlth i BMI")

fit <- lm(data$BMI ~ data$PhysHlth)

abline(fit, col = "red")

# Deskriptivna statistika - kvalitativne varijable
promatranja <- table(data$Diabetes_binary)
pie(promatranja, labels = c("Nema dijabetes", "Ima dijabetes"), main = "Raspodjela po dijabetesu")

promatranja <- table(data$Sex)
pie(promatranja, labels = c("Žene", "Muškarci"), main = "Raspodjela spola")

promatranja <- table(data$HighChol)
pie(promatranja, labels = c("Visok kolesterol", "Nizak kolesterol"), main = "Raspodjela po kolesterolu")

promatranja <- table(data$Age)
pie(promatranja, labels = c("18-24", "25-29", "30-34", "35-39", "40-44",
                            "45-49", "50-54", "55-59", "60-64", "65-69",
                            "70-74", "75-79", "80+ godina"),
    main = "Raspodjela po dobi")

promatranja <- table(data$Education)
pie(promatranja, labels = c("Samo vrtić", "Osnovna", "Nešto srednje škole",
                            "Srednja škola", "Fakultet 1-3 godine",
                            "Fakultet 4 godine ili više"),
    main = "Raspodjela po edukaciji")

promatranja <- table(data$Income)
pie(promatranja, labels = c("Manje od 10.000 dolara", "10.000-15.000 dolara",
                            "15.000-20.000 dolara", "20.000-25.000", "25.000-35.000",
                            "35.000-50.000", "50.000-75.000", "75.000 ili više dolara"),
    main = "Raspodjela po zaradi")