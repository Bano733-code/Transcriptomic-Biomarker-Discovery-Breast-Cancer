library(limma)
library(ggplot2)


load("data_objects.RData")


design <- model.matrix(~group)


fit <- lmFit(expression_data, design)

fit <- eBayes(fit)


results <- topTable(
  fit,
  coef=2,
  number=Inf,
  adjust.method="BH"
)



results$Significance <- "Not Significant"


results$Significance[
  results$adj.P.Val <0.05 &
    results$logFC >1
] <- "Upregulated"



results$Significance[
  results$adj.P.Val <0.05 &
    results$logFC < -1
] <- "Downregulated"



write.csv(
  results,
  "results/tables/DEG_results.csv"
)



ggplot(
  results,
  aes(
    x=logFC,
    y=-log10(adj.P.Val),
    color=Significance
  )
)+
  geom_point()


ggsave(
  "results/figures/Volcano_Plot.png",
  width=8,
  height=6
)


save(results,
     file="results_objects.RData")