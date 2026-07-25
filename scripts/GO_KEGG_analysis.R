library(clusterProfiler)
library(enrichplot)
library(org.Hs.eg.db)


load("results_objects.RData")


sig_genes <- results[
  results$adj.P.Val <0.05 &
    abs(results$logFC)>1,
]


genes <- sig_genes$GeneSymbol


gene_ids <- bitr(
  genes,
  fromType="SYMBOL",
  toType="ENTREZID",
  OrgDb=org.Hs.eg.db
)



ego <- enrichGO(
  gene=gene_ids$ENTREZID,
  OrgDb=org.Hs.eg.db,
  ont="BP",
  pAdjustMethod="BH"
)



dotplot(ego)


ggsave(
  "results/figures/GO_dotplot.png"
)



kegg_result <- enrichKEGG(
  gene=gene_ids$ENTREZID,
  organism="hsa"
)


dotplot(kegg_result)


ggsave(
  "results/figures/KEGG_dotplot.png"
)


save(ego,kegg_result,
     file="GO_KEGG_results.RData")