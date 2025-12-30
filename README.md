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
