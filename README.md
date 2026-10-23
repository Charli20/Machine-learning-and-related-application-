# Diabetes Prediction

This project uses the Tennessee subset of the 2023 BRFSS dataset to study diabetes prediction. It includes data exploration, baseline models and three experiments.

## Setup

Open the project folder in VS Code and install the Python and Jupyter extensions. Install the required libraries:

```powershell
python -m pip install -r requirements_experiments.txt
python -m pip install ipykernel matplotlib seaborn scipy statsmodels xgboost shap
```

Select your Python environment as the notebook kernel.

## Run the notebooks in this order

1. **`EDA.ipynb`** ? Explore the data and class distribution.
2. **`baseline.ipynb`** ? Prepare the data, train baseline models and save the results.
3. **`EXPERIMENT1.ipynb`** ? Compare RFE20, No RFE and RFECV.
4. **`Experiment2_CatBoost_vs_GradientBoosting_Ready.ipynb`** ? Compare CatBoost and Gradient Boosting.
5. **`Experiment3_BalancedRandomForest_vs_RandomForest.ipynb`** ? Compare Random Forest without SMOTE, Random Forest with SMOTE and Balanced Random Forest.

Run all cells from top to bottom and save each notebook before continuing.

## Required files

Keep these files and folders in their original locations:

- `LLCP2023.csv` or `LLCP2023.XPT` ? Raw data for EDA and the baseline.
- `mice_cache/` ? Saved imputed data. Each folder from `fold_1` to `fold_5` needs `train_imputed.csv` and `validation_imputed.csv`.
- `phase3_data/start_data.joblib` ? Saved split for Experiment 1.
- `starting_split.joblib` ? Saved split for Experiments 2 and 3.
- `results/baseline/logistic_regression/cv_metrics.csv`
- `results/baseline/gradient_boosting/cv_metrics.csv`
- `results/baseline/random_forest/cv_metrics.csv`
- `results/baseline/gradient_boosting/cv_fold_metrics.csv`

The baseline saves `phase3_data/start_data.joblib`. If rebuilding the project, copy the same split for Experiments 2 and 3:

```powershell
Copy-Item .\phase3_data\start_data.joblib .\starting_split.joblib
```

The split files must match the saved MICE data. With these saved inputs, the experiments can run without rerunning the baseline.

R and its `mice` package are needed only when regenerating missing MICE data through the baseline. The baseline currently expects R under `C:/Program Files/R`.

## Results

The experiments compare mean validation scores across five folds, including accuracy, precision, recall, F1-score, AUROC and PR-AUC. Results and trained models are saved in the `results/` folder; baseline models are saved in `models/baseline/`.

Saved notebook outputs can also be viewed on GitHub without running the code.
