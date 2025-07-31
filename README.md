# 🧬 Introduction to R for Bioinformatics & Biotechnology

Welcome to the official repository for the **"Introduction to R for Bioinformatics & Biotechnology"** course, proudly organized by **Omnigenics**.

This course is tailored for students and professionals in **biotech, bioinformatics, and other life science disciplines** who are eager to gain practical programming and data analysis skills using **R**.



## 🧠 What You'll Learn

- Fundamentals of **R programming**
- Data visualization using `ggplot2`
- Working with **biological data**
- Case studies in **biotech** and **bioinformatics**
- Preparing your own **project notebook** in R

---

## 📂 Repository Structure

```bash
.
├── lec1/
├── lec2/
├── lec3+4/
├── lec5+6/
├── projects/
└── README.md
# Hands-on-R
Crash R Course by OmniGenics
```
## 📚 Requirements

Make sure to install:

### R & RStudio

- [R](https://cran.r-project.org/)
- [RStudio](https://posit.co/download/rstudio-desktop/)

### R Packages

You can install the required packages using the following R code:

```r
install.packages(c("ggplot2", "readr", "dplyr"))
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Biobase")
