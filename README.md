# Diabetes Prediction

This is my machine learning assignment using the Tennessee data from BRFSS 2023. I explored the dataset, implemented the baseline and carried out three experiments to compare feature selection, classifiers and class balancing methods.

## Before running

I used VS Code with the Python and Jupyter extensions. Install the libraries using:

```powershell
python -m pip install -r requirements_experiments.txt
python -m pip install ipykernel matplotlib seaborn scipy statsmodels xgboost shap
```

Open the project folder in VS Code and select the Python environment as the notebook kernel.

## Notebook order

Run the notebooks in this order:

1. `EDA.ipynb` - Data exploration and checking the class distribution.
2. `baseline.ipynb` - Data preparation, baseline model training and evaluation.
3. `EXPERIMENT1.ipynb` - Comparing RFE20, No RFE and RFECV.
4. `Experiment2_CatBoost_vs_GradientBoosting_Ready.ipynb` - Comparing CatBoost with baseline Gradient Boosting.
5. `Experiment3_BalancedRandomForest_vs_RandomForest.ipynb` - Comparing Random Forest without SMOTE, Random Forest with SMOTE and Balanced Random Forest.

Run the cells from top to bottom and save the notebook after running it.

## Files needed

Keep the folder structure the same because the notebooks use relative paths.

- `LLCP2023.csv` or `LLCP2023.XPT` is needed for EDA and the baseline.
- `mice_cache/` contains the saved imputed data. The folders `fold_1` to `fold_5` each need `train_imputed.csv` and `validation_imputed.csv`.
- `phase3_data/start_data.joblib` is the saved data split used in Experiment 1.
- `starting_split.joblib` is the saved split used in Experiments 2 and 3.

These baseline results are also needed for the comparisons:

```text
results/baseline/logistic_regression/cv_metrics.csv
results/baseline/gradient_boosting/cv_metrics.csv
results/baseline/random_forest/cv_metrics.csv
results/baseline/gradient_boosting/cv_fold_metrics.csv
```

If running the baseline again, it saves the split in `phase3_data/start_data.joblib`. Copy the same split for Experiments 2 and 3:

```powershell
Copy-Item .\phase3_data\start_data.joblib .\starting_split.joblib
```

The split must match the MICE cache files. If the saved inputs are already available, the experiments can run without running the baseline again.

R and the `mice` package are only needed to regenerate missing imputation files through the baseline. The code currently looks for R in `C:/Program Files/R`.

## Results

I compared the mean validation scores across five folds using accuracy, precision, recall, F1-score, AUROC and PR-AUC. The notebooks also report balanced accuracy and specificity.

Experiment results and models are saved in `results/`. Baseline models are saved in `models/baseline/`. The saved notebook outputs can be viewed on GitHub without running the code.
