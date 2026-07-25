library(STRINGdb)
library(igraph)
library(ggraph)


load("results_objects.RData")


string_db <- STRINGdb$new(
  version="12",
  species=9606,
  score_threshold=700
)


genes <- unique(sig_genes$GeneSymbol)


mapped <- string_db$map(
  data.frame(Gene=genes),
  "Gene"
)



ppi <- string_db$get_interactions(
  mapped$STRING_id
)


network <- graph_from_data_frame(
  ppi,
  directed=FALSE
)



deg <- degree(network)


hub_table <- data.frame(
  Gene=names(deg),
  Degree=deg
)



write.csv(
  hub_table,
  "results/tables/Hub_Genes.csv"
)


save(hub_table,
     file="ppi_results.RData")