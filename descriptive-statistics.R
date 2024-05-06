
data <- read.csv(file.choose())

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

plot(data$PhysHlth, data$BMI, xlab = "PhysHlth", ylab = "BMI", main = "Korelacija između PhysHlth i BMI")

fit <- lm(data$BMI ~ data$PhysHlth)

abline(fit, col = "red")