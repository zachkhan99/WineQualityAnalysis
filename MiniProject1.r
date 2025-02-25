# Install packages (if necessary)
#install.packages("corrplot")
#install.packages("moments")

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(corrplot)
library(moments)

# Read wine quality dataset
wine_data <- read.csv("winequality-white.csv", sep=";")

# 1. Basic Statistical Summary
cat("\n Basic Statistical Summary \n")
summary(wine_data)

# 2. Check for missing values
cat("\n Missing Values Check \n")
colSums(is.na(wine_data))

# 3. Distribution of Wine Quality Scores
ggplot(wine_data, aes(x=quality)) +
  geom_bar(fill="steelblue") +
  labs(title="Distribution of Wine Quality Scores",
       x="Quality Score", y="Count")

# 4. Correlation Analysis
numeric_cols <- sapply(wine_data, is.numeric)
correlation_matrix <- cor(wine_data[,numeric_cols])
corrplot(correlation_matrix, method="color", type="upper", 
         tl.col="black", tl.srt=45)

# 5. Box plots for key features
long_data <- wine_data %>%
  select(-quality) %>%
  gather(key="feature", value="value")

ggplot(long_data, aes(x=feature, y=value)) +
  geom_boxplot(fill="steelblue") +
  facet_wrap(~feature, scales="free") +
  theme(axis.text.x = element_text(angle=45))

# 6. Identify potential outliers using IQR method
outliers_summary <- data.frame()
for(col in names(wine_data)[sapply(wine_data, is.numeric)]) {
  Q1 <- quantile(wine_data[[col]], 0.25)
  Q3 <- quantile(wine_data[[col]], 0.75)
  IQR <- Q3 - Q1
  outliers <- sum(wine_data[[col]] < (Q1 - 1.5*IQR) | wine_data[[col]] > (Q3 + 1.5*IQR))
  outliers_summary <- rbind(outliers_summary, 
                            data.frame(Feature=col, Outliers=outliers))
}
print(outliers_summary)

# 7. Quality prediction analysis
model <- lm(quality ~ ., data=wine_data)
summary(model)

# 8. Feature importance analysis
importance <- abs(coef(model)[-1])
feature_importance <- data.frame(
  Feature = names(importance),
  Importance = as.numeric(importance)
)
feature_importance <- feature_importance[order(-feature_importance$Importance),]
print(feature_importance)

# 9. Density plots for key features by quality rating
ggplot(wine_data, aes(x=alcohol, fill=factor(quality))) +
  geom_density(alpha=0.5) +
  labs(title="Alcohol Content Distribution by Quality",
       x="Alcohol Content", y="Density")

# 10. Skewness, Kurtosis, and Spread in Wine Quality
wine_stats <- wine_data %>%
  summarise(
    mean_quality = mean(quality),
    sd_quality = sd(quality),
    skewness_quality = moments::skewness(quality),
    kurtosis_quality = moments::kurtosis(quality),
    quality_range = max(quality) - min(quality)
  )
print(wine_stats)

# Other visualization for most significant features
significant_features <- c("density", "volatile.acidity", "pH", "sulphates", "alcohol")

# Create density plots for each significant feature
for (feature in significant_features) {
  p <- ggplot(wine_data, aes(x = .data[[feature]], fill = factor(quality))) +
    geom_density(alpha = 0.5) +
    labs(title = paste(feature, "Distribution by Quality"),
         x = feature, 
         y = "Density",
         fill = "Quality") +
    theme_minimal()
  print(p)
}

# Analyze the relationship between top features and quality
top_correlations <- wine_data %>%
  select(quality, all_of(significant_features)) %>%
  cor() %>%
  as.data.frame() %>%
  select(quality) %>%
  arrange(desc(abs(quality)))

print("Top Feature Correlations with Quality")
print(top_correlations)
