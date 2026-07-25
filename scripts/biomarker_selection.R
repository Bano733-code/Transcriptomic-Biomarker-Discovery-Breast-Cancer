load("results_objects.RData")
load("ppi_results.RData")


candidate_genes <- intersect(
  sig_genes$GeneSymbol,
  hub_table$Gene
)



write.csv(
  candidate_genes,
  "results/tables/Network_Based_Biomarkers.csv"
)