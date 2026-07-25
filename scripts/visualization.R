library(ggplot2)


load("data_objects.RData")
load("results_objects.RData")


genes <- c(
  "CDC20",
  "AURKA",
  "FOXA1"
)


boxplot_data <- data.frame()


for(gene in genes){
  
  probe <- rownames(results)[
    results$GeneSymbol==gene
  ][1]
  
  
  expr <- expression_data[probe,]
  
  
  temp <- data.frame(
    Gene=gene,
    Expression=as.numeric(expr),
    Group=group
  )
  
  
  boxplot_data <- rbind(
    boxplot_data,
    temp
  )
  
}



ggplot(
  boxplot_data,
  aes(
    x=Gene,
    y=Expression,
    fill=Group
  )
)+
  geom_boxplot()



ggsave(
  "results/figures/Biomarker_Boxplot.png"
)