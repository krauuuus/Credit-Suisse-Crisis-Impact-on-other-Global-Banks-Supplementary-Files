
require(dplyr)
require(ggplot2)
require(tidyr)
require(ggthemes)
##-----PRICES-----##
prices_plots = {
  df_prices %>% dplyr::mutate(Date_1 = as.Date(as.character(df_prices[,1]))) %>% 
    tibble %>% dplyr::select(-1) %>% 
    pivot_longer(cols = -Date_1,names_to = "variables") %>%
    ggplot(aes(x = Date_1,y = value)) +
    geom_line() +
    facet_wrap(~variables,scales = "free_y") + 
    labs(title = "", x= "", y = "")}

##-----RETURNS-----##
returns_plots = {
  df_returns %>% dplyr::mutate(Date_1 = as.Date(as.character(df_returns[,1]))) %>% 
    tibble %>% dplyr::select(-1) %>% 
    pivot_longer(cols = -Date_1,names_to = "variables") %>%
    ggplot(aes(x = Date_1,y = value)) +
    geom_line() +
    facet_wrap(~variables,scales = "free_y") + 
    labs(title = "", x= "", y = "")}
returns_plots+theme_base()+theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))


##-----BILATERAL CONNECTEDNESS-----##
bilateral = {
  all %>% dplyr::mutate(Date_1 = as.Date(as.character(all[,1]))) %>% 
    tibble %>% dplyr::select(-1) %>% 
    pivot_longer(cols = -Date_1,names_to = "variables") %>%
    ggplot(aes(x = Date_1 ,y = value)) +
    geom_line() +
    facet_wrap(~variables,scales = "free_y") + 
    labs(title = "", x= "", y = "")}
bilateral+theme_base()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  geom_vline(xintercept = as.Date("2023-03-14"), linetype="dashed", color="red")+
  geom_vline(xintercept = as.Date("2022-10-01"), linetype="dashed", color="blue")

##---ZOOM END----##
all2<-all[all[,1] >= "2023-03-01" & all[,1] <= "2023-04-01", ] 
bilateral2 = {
  all2 %>% dplyr::mutate(Date_1 = as.Date(as.character(all2[,1]))) %>% 
    tibble %>% dplyr::select(-1) %>% 
    pivot_longer(cols = -Date_1,names_to = "variables") %>%
    ggplot(aes(x = Date_1 ,y = value)) +
    geom_line() +
    facet_wrap(~variables,scales = "free_y") + 
    labs(title = "", x= "", y = "")}
bilateral2+theme_base()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  geom_vline(xintercept = as.Date("2023-03-14"), linetype="dashed", color="red")+
  geom_vline(xintercept = as.Date("2023-03-20"), linetype="dashed", color="blue")+
  geom_vline(xintercept = as.Date("2023-03-17"), linetype="dashed", color="green")



##-----------NET BILATERAL CONNECTEDNESS-----------##
net_bilateral = {
  net_all %>% dplyr::mutate(Date_1 = as.Date(as.character(net_all[,1]))) %>% 
    tibble %>% dplyr::select(-1) %>% 
    pivot_longer(cols = -Date_1,names_to = "variables") %>%
    ggplot(aes(x = Date_1 ,y = value)) +
    geom_line() +
    facet_wrap(~variables,scales = "free_y") + 
    labs(title = "", x= "", y = "")}
net_bilateral+
  theme_base()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  geom_hline(yintercept = 0)+
  geom_vline(xintercept = as.Date("2023-03-14"), linetype="dashed", color="red")+
  geom_vline(xintercept = as.Date("2022-10-01"), linetype="dashed", color="blue")

net_all2<-net_all[net_all[,1] >= "2023-03-01" & net_all[,1] <= "2023-04-01", ] 
net_bilateral2 = {
  net_all2 %>% dplyr::mutate(Date_1 = as.Date(as.character(net_all2[,1]))) %>% 
    tibble %>% dplyr::select(-1) %>% 
    pivot_longer(cols = -Date_1,names_to = "variables") %>%
    ggplot(aes(x = Date_1 ,y = value)) +
    geom_line() +
    facet_wrap(~variables,scales = "free_y") + 
    labs(title = "", x= "", y = "")}
net_bilateral2+
  theme_base()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  geom_hline(yintercept = 0)+
  geom_vline(xintercept = as.Date("2023-03-14"), linetype="dashed", color="red")+
  geom_vline(xintercept = as.Date("2023-03-20"), linetype="dashed", color="blue")+
  geom_vline(xintercept = as.Date("2023-03-17"), linetype="dashed", color="green")




##Network Plot (not the one in the paper, easier)
PlotNetwork(connectedness,method="PCI")

##other options for matrix plot
start_mat<-matrix(connectedness$PCI, ncol=14, nrow=14)
colnames(start_mat)=rownames(start_mat)=names(Donnees_returns)
start_mat

gr_start = graph.adjacency(start_mat, mode = "undirected", weighted = TRUE, diag=F)

##another one (in the paper)
E(gr_start)$width<-E(gr_start)$weight/30

lo=layout_with_fr(gr_start)

plot.igraph(gr_start, axes=F,
            vertex.size=35,
            vertex.color="#E0E0E0",
            layout=lo,
            vertex.label = V(gr_start)$name,
            vertex.label.cex = 0.99,  
            vertex.label.color = "black",
            edge.color = "black", 
            edge.width=E(gr_start)$width,
            label=TRUE, 
            edge.arrow.size = 0.1, 
            edge.curved = 0.35, 
            lty = 2, 
            xlim = c(-0,0), ylim=c(-1,1))

legend(x=-1.7, y=1.2, "TCI = 78,29%", box.lwd = 3,
       text.col = "black", cex=1.25, pt.cex=1)
