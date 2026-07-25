library(ggplot2)
library(enrichplot)
library(clusterProfiler)
library(stringr)


# Convert GO result to dataframe
go_df <- as.data.frame(ego)


# Select top 10 significant pathways
go_df <- go_df[1:10, ]


# Wrap long pathway names
go_df$Description <- str_wrap(
  go_df$Description,
  width = 45
)


# Create horizontal barplot
go_barplot <- ggplot(
  go_df,
  aes(
    x = reorder(Description, -log10(p.adjust)),
    y = -log10(p.adjust)
  )
) +
  geom_bar(
    stat = "identity"
  ) +
  coord_flip() +
  theme_classic() +
  labs(
    title = "GO Biological Process Enrichment",
    x = "",
    y = "-log10 Adjusted P-value"
  ) +
  theme(
    plot.title = element_text(
      size = 14,
      face = "bold"
    ),
    axis.text.y = element_text(
      size = 10
    )
  )


go_barplot


ggsave(
  "results/figures/GO_barplot.png",
  go_barplot,
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
