###################################################
# Breast Cancer Biomarker Discovery Pipeline
# GEO Dataset: GSE42568
###################################################


# Clear environment

rm(list = ls())


# Set project directory

setwd(
  "C:/Users/banor/Downloads/NWE/Breast_Cancer_Biomarker_Project"
)



cat("====================================\n")
cat("Breast Cancer Biomarker Pipeline\n")
cat("Starting Analysis...\n")
cat("====================================\n\n")



###################################################
# 1. Data Loading
###################################################

cat("Running Step 1: Data Loading...\n")

source(
  "scripts/01_data_loading.R"
)



###################################################
# 2. Differential Expression Analysis
###################################################

cat("Running Step 2: Differential Expression...\n")

source(
  "scripts/02_differential_expression.R"
)



###################################################
# 3. GO and KEGG Pathway Analysis
###################################################

cat("Running Step 3: GO KEGG Analysis...\n")

source(
  "scripts/03_GO_KEGG_analysis.R"
)



###################################################
# 4. PPI Network Analysis
###################################################

cat("Running Step 4: PPI Network...\n")

source(
  "scripts/04_PPI_network.R"
)



###################################################
# 5. Survival Analysis
###################################################

cat("Running Step 5: Survival Analysis...\n")

source(
  "scripts/05_survival_analysis.R"
)



###################################################
# 6. Biomarker Selection
###################################################

cat("Running Step 6: Biomarker Selection...\n")

source(
  "scripts/06_biomarker_selection.R"
)



###################################################
# 7. Visualization
###################################################

cat("Running Step 7: Visualization...\n")

source(
  "scripts/07_visualization.R"
)



cat("\n====================================\n")
cat("Pipeline Completed Successfully!\n")
cat("Check results folder\n")
cat("====================================\n")