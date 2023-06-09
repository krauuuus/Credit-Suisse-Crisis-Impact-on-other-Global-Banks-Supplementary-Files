require(stargazer)
require(vars)
require(tidyr)
require(dplyr)
require(ggplot2)
install.packages("ggthemes")
require(ggthemes)
require(igraph)
library(GGally)
library(ggnet)

library(network)
library(sna)

VARselect(Donnees_returns, lag.max=7, type="none") #nlag=1
connectedness<-ConnectednessApproach(Donnees_returns, 
                                     nlag=1,
                                     nfore=10, 
                                     model="TVP-VAR", 
                                     connectedness="Extended Joint")
View(connectedness$TABLE) ##connectedness table
PlotTCI(connectedness,  ylim=c(0,100)) ##Total Connectedness Index

PlotPCI(connectedness,  selection=1, ylim=c(0,100)) ## Pairwise Connectedness Index
PlotNPDC(connectedness, selection=1) ## Net Pairwise Connectedness Index

connectedness_with_CS<-connectedness$PCI[-1,,]
connectedness_with_CS2<-connectedness_with_CS[,1,]

CS_BAC<-connectedness_with_CS2[1,]
CS_BCS<-connectedness_with_CS2[2,]
CS_C<-connectedness_with_CS2[3,]
CS_DB<-connectedness_with_CS2[4,]
CS_HSBC<-connectedness_with_CS2[5,]
CS_JPM<-connectedness_with_CS2[6,]
CS_GS<-connectedness_with_CS2[7,]
CS_MS<-connectedness_with_CS2[8,]
CS_CA<-connectedness_with_CS2[9,]
CS_UBS<-connectedness_with_CS2[10,]
CS_SAN<-connectedness_with_CS2[11,]
CS_WFC<-connectedness_with_CS2[12,]
CS_BNP<-connectedness_with_CS2[13,]

time=as.Date(df_returns[-100,1])

all<-data.frame(time,"BankofAmerica"=CS_BAC,"Barclays"=CS_BCS,
                "Citigroup"=CS_C, "DeutschBank"=CS_DB,
                "HSBC"=CS_HSBC,"JPMorgan"=CS_JPM, "GoldmanSachs"=CS_GS,
                "MorganStanley"=CS_MS, "CreditAgricole"=CS_CA,
                "UBS"=CS_UBS, "Santander"=CS_SAN, 
                "WellsFargo"=CS_WFC, "BNPParibas"=CS_BNP)


net_connectedness_with_CS<-connectedness$NPDC[-1,,]
net_connectedness_with_CS2<-net_connectedness_with_CS[,1,]

net_CS_BAC<-net_connectedness_with_CS2[1,]
net_CS_BCS<-net_connectedness_with_CS2[2,]
net_CS_C<-net_connectedness_with_CS2[3,]
net_CS_DB<-net_connectedness_with_CS2[4,]
net_CS_HSBC<-net_connectedness_with_CS2[5,]
net_CS_JPM<-net_connectedness_with_CS2[6,]
net_CS_GS<-net_connectedness_with_CS2[7,]
net_CS_MS<-net_connectedness_with_CS2[8,]
net_CS_CA<-net_connectedness_with_CS2[9,]
net_CS_UBS<-net_connectedness_with_CS2[10,]
net_CS_SAN<-net_connectedness_with_CS2[11,]
net_CS_WFC<-net_connectedness_with_CS2[12,]
net_CS_BNP<-net_connectedness_with_CS2[13,]

net_all<-data.frame(time,"BankofAmerica"=net_CS_BAC,"Barclays"=net_CS_BCS,
                "Citigroup"=net_CS_C, "DeutschBank"=net_CS_DB,
                "HSBC"=net_CS_HSBC,"JPMorgan"=net_CS_JPM, "GoldmanSachs"=net_CS_GS,
                "MorganStanley"=net_CS_MS, "CreditAgricole"=net_CS_CA,
                "UBS"=net_CS_UBS, "Santander"=net_CS_SAN, "WellsFargo"=net_CS_WFC, 
                "BNPParibas"=net_CS_BNP)



