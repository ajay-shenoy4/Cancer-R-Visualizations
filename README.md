# STAT 436 – Data Visualization & Genomics  
**Author:** Ajay Shenoy  
**Course:** STAT 436  
**Language:** R  

This repository contains coursework demonstrating exploratory data analysis, statistical visualization, and biological interpretation using R. The projects span **RNA-seq transcriptomic analysis** and **interactive geospatial visualization**, highlighting both static and interactive data visualization techniques.

---

## Homework 5: RNA-seq Analysis of Leukemia Subtypes

### Overview
This project analyzes RNA-seq gene expression data from leukemia samples to investigate whether **transcriptional profiles distinguish biological subtypes**:

- **MPAL** – Mixed-Phenotype Acute Leukemia  
- **AML-MP** – Acute Myeloid Leukemia with Mixed Phenotype  
- **AML** – Single-Phenotype Acute Myeloid Leukemia  

The analysis tests the hypothesis that **mixed-lineage leukemias exhibit distinct transcriptional signatures** due to their ambiguous cellular identity (myeloid vs lymphoid).

---

### Data
- **Input:** HTSeq gene-level raw counts  
- **Format:** Genes × Samples count matrix  
- **Source:** GEO dataset `GSE275859` (hg19 reference)  

---

### Methods
- **Normalization:** Variance Stabilizing Transformation (VST)  
- **Dimensionality Reduction:** Principal Component Analysis (PCA)  
- **Gene Variability:** Variance-based gene selection  
- **Clustering:** Hierarchical clustering (Euclidean distance, complete linkage)  

---

### Visualizations

#### 1) PCA Plot
**Question:**  
Do gene-expression profiles cluster leukemia samples by biological subtype?

**Interpretation:**  
- PCA reduces high-dimensional gene expression into two principal axes.
- Samples are color-coded by subtype and labeled by sample ID.
- Results show clear separation between **AML** and mixed-phenotype groups (**AML-MP, MPAL**), suggesting transcriptional differences driven by lineage ambiguity.

**Limitation:**  
PCA captures only dominant variance patterns and may miss subtler biologically meaningful differences.

---

#### 2) Heatmap of Top 100 Most Variable Genes
**Question:**  
Which genes contribute most strongly to subtype differences?

**Approach:**  
- Selected the 100 genes with highest variance across samples.
- Applied Z-score scaling to emphasize relative expression changes.
- Performed unsupervised hierarchical clustering of both genes and samples.

**Interpretation:**  
- Samples cluster by subtype without prior labeling.
- Identifies gene-level drivers of transcriptional differences.
- Highlights genes involved in **myeloid differentiation, T-cell identity, and stemness**, consistent with known leukemia biology.

---

### Key Biological Insight
Both PCA and heatmap analyses demonstrate that:
- **Mixed-phenotype leukemias occupy a distinct transcriptional space**
- Specific genes (e.g., *CD3D*, *U2AF1*) help explain lineage ambiguity
- Transcriptional regulation reflects underlying biological and clinical differences

---

## Interactive Shiny App: Breast Cancer Feature Visualization & Prediction

### Overview
This project is an **interactive Shiny application** that explores tumor characteristics from a breast cancer dataset and allows users to **visualize feature distributions** and **predict tumor malignancy** using a logistic regression model.

The app is designed to make statistical modeling and exploratory analysis **accessible and interpretable** through interactive controls.

---

### Data
- **Dataset:** Breast cancer tumor measurements  
- **Features:** Numeric tumor characteristics (e.g., radius, texture, concavity)  
- **Target Variable:**  
  - `B` = Benign  
  - `M` = Malignant  

Unnecessary identifier columns were removed prior to analysis.

---

### App Features

#### 1) Interactive Feature Visualization
- Users select a tumor feature (e.g., mean radius, texture, concavity)
- Boxplots display the distribution of the selected feature by diagnosis
- Users can filter by:
  - Both tumor types
  - Benign only
  - Malignant only

**Purpose:**  
To visually assess which tumor characteristics differ most strongly between benign and malignant tumors.

---

#### 2) Logistic Regression Prediction
A logistic regression model is trained using:
- `radius_mean`
- `texture_mean`
- `concavity_mean`

Users input custom values for these features, and the app:
- Predicts tumor type (Benign or Malignant)
- Displays the probability of malignancy

**Interpretation:**  
This allows users to see how changes in tumor characteristics influence predicted cancer risk in real time.

---

### Statistical Model
- **Model type:** Logistic regression (`glm`, binomial family)
- **Goal:** Estimate probability that a tumor is malignant
- **Output:** Class prediction + probability score

---

### Learning Outcomes
This application demonstrates:
- Interactive data visualization with `ggplot2` and `shiny`
- Feature-based filtering and reactive programming
- Applied logistic regression for classification
- Clear communication of statistical results to end users

---

## R Packages Used
- **Data manipulation:** `dplyr`
- **Visualization:** `ggplot2`, `pheatmap`
- **Genomics:** `DESeq2`
- **Interactivity:** `shiny`

---
