# Wine Quality Analysis

## Project Overview
This project analyzes the **Wine Quality Dataset** from the UCI Machine Learning Repository. The dataset contains physicochemical attributes of white wine samples from the **Vinho Verde** region of Portugal. The goal is to explore relationships between these attributes and wine quality using data analysis and visualization techniques in **R**.

## Dataset
- **Source:** [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Wine+Quality)
- **Files Used:**
  - `winequality-white.csv`: White wine dataset
  - `winequality-red.csv`: Red wine dataset (not analyzed in this project)
- **Attributes:** 12 physicochemical properties, including acidity, residual sugar, pH, sulphates, alcohol, and a **quality score** (ranging from 3 to 9).

## Files in This Repository
- `Miniproject1.r` – R script containing all data analysis steps.
- `Miniproject1.docx` – Detailed report on the analysis.
- `Plots/` – Folder containing generated visualizations.
- `winequality-white.csv` – Dataset used for analysis.

## Analysis and Key Operations
1. **Data Cleaning & Summary**
   - Checked for missing values and basic statistics.
2. **Exploratory Data Analysis (EDA)**
   - Visualized the distribution of wine quality scores.
   - Box plots and density plots for key features.
3. **Correlation Analysis**
   - Identified relationships between wine quality and other attributes.
4. **Outlier Detection**
   - Used the IQR method to detect extreme values.
5. **Linear Regression Model**
   - Built a model to predict wine quality based on physicochemical attributes.
6. **Feature Importance Analysis**
   - Determined which attributes have the most impact on quality.
7. **Statistical Analysis**
   - Examined standard deviation, skewness, kurtosis, and quality range.

## How to Run the Code
1. Ensure **R** and required libraries (`ggplot2`, `dplyr`, `tidyr`, `corrplot`, `moments`) are installed.
2. Open `Miniproject1.r` in **RStudio** or any R environment.
3. Run the script to generate summary statistics and plots.
4. Results will be displayed in the console, and plots will be saved in the `Plots/` folder.

## Results & Insights
- **Alcohol content** showed the highest positive correlation with wine quality.
- **Density** had a strong negative correlation with quality.
- The dataset contained several outliers, especially in acidity and chlorides.
- The linear regression model explained **28% of the variance** in wine quality.

## Future Improvements
- Use machine learning models (e.g., Random Forest, SVM) for better quality prediction.
- Perform a comparative analysis on red vs. white wine datasets.
- Investigate additional factors like production methods and sensory evaluations.

## Author
**Zach Khan**

