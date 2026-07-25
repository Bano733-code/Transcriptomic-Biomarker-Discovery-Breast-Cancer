library(clusterProfiler)
library(enrichplot)
library(org.Hs.eg.db)
library(ggplot2)
library(stringr)


load("results_objects.RData")


# Significant genes

sig_genes <- results[
  results$adj.P.Val < 0.05 &
    abs(results$logFC) > 1,
]


genes <- sig_genes$GeneSymbol


# Convert SYMBOL to ENTREZ ID

gene_ids <- bitr(
  genes,
  fromType = "SYMBOL",
  toType = "ENTREZID",
  OrgDb = org.Hs.eg.db
)



############################
# GO ENRICHMENT
############################


ego <- enrichGO(
  gene = gene_ids$ENTREZID,
  OrgDb = org.Hs.eg.db,
  ont = "BP",
  pAdjustMethod = "BH",
  pvalueCutoff = 0.05
)


go_df <- as.data.frame(ego)


go_df <- go_df[1:10,]


go_df$Description <- str_wrap(
  go_df$Description,
  width = 45
)


go_plot <- ggplot(
  go_df,
  aes(
    x = reorder(Description, -log10(p.adjust)),
    y = -log10(p.adjust)
  )
)+
geom_bar(stat="identity")+
coord_flip()+
theme_classic()+
labs(
title="GO Biological Process Enrichment",
x="",
y="-log10 Adjusted P-value"
)


go_plot


ggsave(
"results/figures/GO_barplot.png",
go_plot,
width=10,
height=7,
dpi=300
)



############################
# KEGG ENRICHMENT
############################


kegg_result <- enrichKEGG(
  gene = gene_ids$ENTREZID,
  organism = "hsa",
  pvalueCutoff = 0.05
)



kegg_plot <- dotplot(
  kegg_result,
  showCategory = 10,
  font.size = 10
)+
ggtitle(
"KEGG Pathway Enrichment Analysis"
)+
theme(
plot.title = element_text(
size=14,
face="bold"
)
)


kegg_plot


ggsave(
"results/figures/KEGG_dotplot.png",
kegg_plot,
width=10,
height=7,
dpi=300
)



save(
ego,
kegg_result,
file="GO_KEGG_results.RData"
)
