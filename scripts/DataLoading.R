library(GEOquery)
library(limma)

gse <- getGEO("GSE42568", GSEMatrix = TRUE)

data <- gse[[1]]

expression_data <- exprs(data)

pheno <- pData(data)


group <- ifelse(
  pheno$`tissue:ch1` == "normal breast",
  "Normal",
  "Tumor"
)

group <- factor(group)


save(
  expression_data,
  pheno,
  group,
  data,
  file="data_objects.RData"
)