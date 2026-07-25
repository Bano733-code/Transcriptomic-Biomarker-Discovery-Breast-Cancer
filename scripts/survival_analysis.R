library(survival)
library(survminer)


load("data_objects.RData")
load("results_objects.RData")


surv_data <- data.frame(
  Sample=row.names(pheno),
  time=as.numeric(pheno$`overall survival time_days:ch1`),
  status=as.numeric(pheno$`overall survival event:ch1`)
)


surv_data <- surv_data[
  complete.cases(surv_data),
]


# Example gene

gene_expression <- expression_data["MEDAG",]


common_samples <- intersect(
  names(gene_expression),
  surv_data$Sample
)


df <- data.frame(
  time=surv_data$time[
    match(common_samples,surv_data$Sample)
  ],
  
  status=surv_data$status[
    match(common_samples,surv_data$Sample)
  ],
  
  expression=as.numeric(
    gene_expression[common_samples]
  )
)



fit <- survfit(
  Surv(time,status)~expression>median(expression),
  data=df
)


ggsurvplot(
  fit,
  data=df
)