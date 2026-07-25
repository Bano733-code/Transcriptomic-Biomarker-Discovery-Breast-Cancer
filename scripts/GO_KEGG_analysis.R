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

go_plot <- dotplot(
  ego,
  showCategory = 10,
  font.size = 10
) +
  ggtitle("Gene Ontology Biological Process Enrichment") +
  theme(
    plot.title = element_text(
      size = 14,
      face = "bold"
    )
  )

go_plot


ggsave(
  "results/figures/GO_dotplot.png",
  go_plot,
  width = 10,
  height = 7,
  dpi = 300
)

kegg_result <- enrichKEGG(
  gene=gene_ids$ENTREZID,
  organism="hsa"
)


dotplot(kegg_result)

kegg_plot <- dotplot(
  kegg_result,
  showCategory = 10,
  font.size = 10
) +
  ggtitle("KEGG Pathway Enrichment Analysis") +
  theme(
    plot.title = element_text(
      size = 14,
      face = "bold"
    )
  )


kegg_plot


ggsave(
  "results/figures/KEGG_dotplot.png",
  kegg_plot,
  width = 10,
  height = 7,
  dpi = 300
)


save(ego,kegg_result,
     file="GO_KEGG_results.RData")
