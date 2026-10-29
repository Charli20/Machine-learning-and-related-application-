# RFECV settings experiment

Compared step=1 or 5 and inner CV=3 or 5 across the existing five outer training/validation folds. All three final classifiers retain their selected baseline parameters and random_state=42. The selector retains LogisticRegression(solver="liblinear", max_iter=1000, random_state=42), scoring="f1", and min_features_to_select=1. SMOTE is fitted after selection on outer-training rows only. No test-set predictions or production model files were generated.

Mean outer-validation F1:

| Step | Inner folds | Logistic Regression | Gradient Boosting | Random Forest |
|---|---|---|---|---|
| 5 | 3 | 0.481249 | 0.466230 | 0.482268 |
| 1 | 3 | 0.468316 | 0.464333 | 0.474619 |
| 5 | 5 | 0.470788 | 0.447711 | 0.468399 |
| 1 | 5 | 0.476815 | 0.463402 | 0.474459 |

Recommendation: retain step=5 and three inner folds. It has the highest mean F1 for each classifier among these four configurations. Differences are exploratory and do not establish statistical superiority. The same validation folds are used to compare configurations; use the untouched test set only after freezing the final choice.

Feature selection uses a shared logistic regression estimator; these are not classifier-specific RFECV searches. MICE imputation and encoding were prepared per outer training fold, not refitted inside each RFECV inner fold. Inner scores therefore are selection aids, not independent performance estimates. Outer validation scores are the reported metrics.

See fold_scores.csv for individual scores and feature counts; summary.csv includes mean and sample standard deviation for F1, balanced accuracy, specificity, recall, and feature count. Run python rfecv_settings_check.py from the notebook directory to reproduce.
