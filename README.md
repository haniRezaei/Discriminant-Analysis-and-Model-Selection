# Discriminant-Analysis-and-Model-Selection
This project involves implementing Linear Discriminant Analysis (LDA), Logistic Regression, and Model Selection techniques using the SAheart and prostate datasets from the ElemStatLearn package in R. Here's a summary of the steps involved in the project:

* Linear Discriminant Analysis (LDA) on the SAheart Dataset
The SAheart dataset is used to predict coronary heart disease (CHD) using several predictors.
The dataset is split into training and validation sets, and LDA is applied to the training data.
The performance of LDA is evaluated on the validation set using a confusion matrix and misclassification rate.

* Logistic Regression on the SAheart Dataset
Logistic Regression is applied to the same training set.
The model's performance is compared with LDA by calculating the misclassification rate on the validation set and comparing the results.

* Model Selection on the prostate Dataset
The prostate dataset is used for model selection using best subset selection, forward selection, backward elimination, and a hybrid approach.
These methods are implemented using the regsubsets function from the leaps package to determine the best subset of predictors for predicting prostate-specific antigen (PSA) levels.

* Cross-Validation for Model Selection
A custom predict.regsubsets function is created to make predictions for each subset of predictors.
A 5-fold Cross-Validation (CV) approach is used to evaluate different models based on the Mean Squared Error (MSE) for each fold.
The optimal number of predictors is chosen based on CV errors.

This project demonstrates how to apply classification techniques like LDA and Logistic Regression, along with model selection techniques, to real-world datasets for predictive analysis.
