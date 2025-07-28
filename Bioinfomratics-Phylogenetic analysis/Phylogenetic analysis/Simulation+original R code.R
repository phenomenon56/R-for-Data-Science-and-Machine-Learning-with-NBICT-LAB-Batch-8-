# Generate 40 fake Salmonella strain names
species <- c("S.enterica", "S.bongori", "S.typhi", "S.typhimurium", "S.paratyphi",
             "S.choleraesuis", "S.arizonae", "S.agona", "S.newport", "S.heidelberg")
strains <- paste0(sample(species, 40, replace = TRUE), "_Strain", 1:40)

# Build random pairs recursively to simulate a tree
make_tree <- function(tips) {
  while (length(tips) > 1) {
    i <- sample(1:(length(tips) - 1), 1)
    new_node <- paste0("(", tips[i], ":0.1,", tips[i+1], ":0.1):0.2")
    tips <- tips[-c(i, i+1)]
    tips <- append(tips, new_node)
  }
  return(paste0(tips, ";"))
}

tree_string <- make_tree(strains)

# Save Newick tree
writeLines(tree_string, "salmonella_40_tree.nwk")
# Simulate metadata
set.seed(123)
metadata <- data.frame(
  Strain = gsub(" ", "_", strains),
  Country = sample(c("USA", "India", "Bangladesh", "UK", "Nepal", "China", "Pakistan"), 40, replace = TRUE),
  Source = sample(c("human", "animal", "environment"), 40, replace = TRUE),
  Susceptiblity = sample(c("MDR", "PDR", "NR"), 40, replace = TRUE),
  Year = sample(1990:2022, 40, replace = TRUE)
)

write.csv(metadata, "salmonella_40_metadata.csv", row.names = FALSE)

# Step 2: Build circular tree with metadata
p <- ggtree(tree, layout = "circular", size = 0.8) %<+% meta +
  geom_tippoint(aes(color = Source), size = 2.5) +
  theme(legend.position = "right")
p

# Step 3: Simulate fake bootstrap support (just for demo)
p$data$SH_aLRT <- sample(50:100, nrow(p$data), replace = TRUE)
p$data$UFboot <- sample(50:100, nrow(p$data), replace = TRUE)
p$data$bootstrap <- ifelse(p$data$SH_aLRT >= 70 & p$data$UFboot >= 70, "1", "0")

# Step 4: Add bootstrap overlay
p <- p + new_scale_color() +
  geom_tree(aes(color = bootstrap == "1"), size = 0.9) +
  scale_color_manual(name = "Bootstrap", values = c("TRUE" = "black", "FALSE" = "gray70"), guide = "none")

p
meta.sus <- data.frame(Susceptibility = meta$Susceptiblity)
rownames(meta.sus) <- meta$Strain

p1 <- gheatmap(p, meta.sus, offset = 1.9, width = 0.32, colnames = FALSE) +
  scale_fill_viridis_d(option = "A", name = "Susceptibility") +
  new_scale_fill()

meta.year <- data.frame(Year = meta$Year)
rownames(meta.year) <- meta$Strain

p2 <- gheatmap(p1, meta.year, offset = 2.6, width = 0.24, colnames = FALSE) +
  scale_fill_viridis(option = "D", name = "Year")


final_plot <- p2 +
  geom_tiplab2(aes(label = Country), offset = 0.60, size = 2.5, color = "gray40")

final_plot




ggsave("salmonella_circular_tree.png", final_plot, width = 10, height = 10, dpi = 300)














