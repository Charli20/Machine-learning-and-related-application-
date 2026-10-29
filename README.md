# Diabetes Prediction

## Download the dataset

For this assignment, I used the Tennessee data from BRFSS 2023.

1. Download `LLCP2023XPT.zip` ("https://www.cdc.gov/brfss/annual_data/2023/files/LLCP2023XPT.zip?"), which contains the dataset. It is available on the [CDC BRFSS 2023 data page](https://www.cdc.gov/brfss/annual_data/annual_2023.html) under **2023 BRFSS Data (SAS Transport Format)**.
2. Extract `LLCP2023.XPT` from the ZIP into the main project folder, next to `baseline.ipynb`.

After installing the libraries below, run `baseline.ipynb`. It automatically converts the extracted XPT file to `LLCP2023.csv` if the CSV is missing, then continues with the baseline. If the CSV already exists, it uses that file. A separate conversion script is not needed.

## Before running

I used VS Code with the Python and Jupyter extensions. Open the project folder and install the Python libraries using:

```powershell
python -m pip install pandas numpy joblib "scikit-learn>=1.2" "imbalanced-learn>=0.13" catboost ipython ipykernel matplotlib seaborn scipy statsmodels xgboost shap
```

This command includes the packages listed in `requirements_experiments.txt` and the extra libraries used by the notebooks. You can copy it directly from this README to install them.

Select the same Python environment as the notebook kernel. Keep the notebooks in the main project folder so they can find the data and saved files.

## Notebook order

Run the notebooks in this order:

1. `baseline.ipynb` - Creates the CSV if needed, prepares the data, trains the baseline models and evaluates them.
2. `EDA.ipynb` - Data exploration and checking the class distribution. This notebook can also be run separately.
3. `EXPERIMENT1.ipynb` - Comparing RFE20, No RFE and RFECV.
4. `Experiment2_CatBoost_vs_GradientBoosting.ipynb` - Comparing CatBoost with baseline Gradient Boosting.
5. `Experiment3_BalancedRandomForest_vs_RandomForest.ipynb` - Comparing Random Forest without SMOTE, Random Forest with SMOTE and Balanced Random Forest.
6. `hypothesis 2.ipynb` 

Run the cells in each notebook from top to bottom. After finishing the baseline, copy the saved split as explained below before running Experiments 2 and 3 and Hypothesis 2.

## Saved files needed

Keep these files and folders in the project:

```text
mice_cache/
    fold_1/
    fold_2/
    fold_3/
    fold_4/
    fold_5/
    final/
phase3_data/
    start_data.joblib
starting_split.joblib
results/
    baseline/
```

Keep all the files inside `mice_cache/`, including `train.csv`, `validation.csv`, `train_imputed.csv` and `validation_imputed.csv` in each folder. Hypothesis 2 also uses the original cached CSV files to check the data.

The notebooks reuse these saved imputed files. R is only needed if the baseline has to create missing imputation files. In that case, install R and its `mice` package. The current code looks for R under `C:/Program Files/R`.

The saved splits are used by the experiments. The files in `results/baseline/` are used to compare the experiment scores with the baseline scores.

## After running the baseline

The baseline saves the data split in `phase3_data/start_data.joblib`. Experiment 1 reads this file directly.

Before running Experiments 2 and 3 and Hypothesis 2, copy the same split to `starting_split.joblib`. Run this command from the project folder:

```powershell
Copy-Item .\phase3_data\start_data.joblib .\starting_split.joblib
```

Keep the same split settings when using the saved MICE files. The split and the cached data must contain the same rows in the same order.

The baseline also saves its models and preprocessing in `models/baseline/`. To run Experiment 2 without running the baseline first, include these two files as well as the saved splits, caches and baseline results:

```text
models/baseline/preprocessing.joblib
models/baseline/gradient_boosting.joblib
```

## Results

I compared the models using accuracy, precision, recall, F1-score, AUROC and PR-AUC across five validation folds. The notebooks also report balanced accuracy and specificity.

The result folders are:

- Baseline: `results/baseline/`
- Experiment 1: `results/untitled180/`
- Experiment 2: `results/experiment2_catboost_vs_gradient_boosting/`
- Experiment 3: `results/experiment3_balanced_random_forest/`
- Hypothesis 2: `results/hypothesis_2/`

Baseline models are saved in `models/baseline/`. The experiment notebooks save their models in their result folders. The saved notebook outputs can also be viewed on GitHub without running the code.
