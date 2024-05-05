install.packages("car")
require("car")

data <- read.csv(file.choose())

data$Diabetes_binary <- as.factor(data$Diabetes_binary)

data$BMI_Group <- cut(data$BMI, breaks = c(0, 18.5, 24.9, 29.9, 39.9, Inf), 
                      labels = c("Underweight", "Healthy weight", "Overweight", "Obesity", "Severe obesity"))
data$Age_Group <- cut(data$Age, breaks = c(seq(0, 13, by=3)), labels = c("18-34", "35-54", "55-69", "70-80+"))
data$Education_Group <- cut(data$Education, breaks = c(seq(0, 6, by=2)), labels = FALSE)

vars <- c("HighChol", "CholCheck", "BMI_Group", "HvyAlcoholConsump", "AnyHealthcare", "NoDocbcCost",
          "Sex", "Age_Group", "Education_Group", "Income")

for (var in vars) {
  Tab <- table(data$Diabetes_binary, data[[var]])
  cat("Table for", var, ":\n")
  print(Tab)
  barplot(Tab, beside = TRUE, legend = TRUE, main = paste("Barplot for", var))
  
  CTest <- chisq.test(Tab, correct = TRUE)
  cat("\nH0: The", var, "is independent of Diabetes_binary\n")
  cat("H1: The", var, "is not independent of Diabetes_binary\n\n")
  print(CTest)
  
  p_value <- CTest$p.value
  
  if (p_value <= 0.01) {
    cat("\nReject H0: There is a significant association between", var, "and Diabetes_binary\n\n")
  } else {
    cat("\nFail to reject H0: There is no significant association between", var, "and Diabetes_binary\n\n")
  }
}

vars_to_test <- c("BMI", "Age")

for (var in vars_to_test) {
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


  if (sw_test_diabetic$p.value > 0.01 & sw_test_nondiabetic$p.value > 0.01) {
    cat("Both groups follow a normal distribution.\n")
    
    if (f_test$p.value > 0.01 && levene_test$p.value && bartlett_test$p.value) {
      cat("Variances of both groups are equal.\n")
      cat("Performing parametric two-sample t-test...\n")
      
      t_test <- t.test(data[[var]] ~ data$Diabetes_binary, conf.level = 0.99)
      print(t_test)
  
      if (t_test$p.value <= 0.01) {
        cat("\nReject H0: There is a significant difference in ", var, " between diabetic and non-diabetic groups.\n")
      } else {
        cat("\nFail to reject H0: There is no significant difference in ", var," between diabetic and non-diabetic groups.\n")
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


