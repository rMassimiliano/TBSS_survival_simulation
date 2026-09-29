library(dplyr)
library(TBSS)
library(ggplot2)
library(igraph)
library(ggraph)
library(tidygraph)

data("tree_example", package = 'TBSS')
head(tree_example)

gr = graph_from_data_frame(tree_example[,2:1])

gr |>
 as_tbl_graph() |> 
 ggraph('igraph', algorithm = 'tree') + 
 geom_edge_link(color ='#00249c') +
 geom_node_label(aes(label= name), size = 4,show.legend = FALSE)+  
 ggforce::theme_no_axes() 
 ggsave("sim_tree.pdf", height = 9, width =9)

