library(quantmod)
require(zoo)

symbols<-c("CS","BAC","BCS","C", "DB", 
           "HSBC", "JPM", "GS", "MS", 
           "CRARY", "UBS", "SAN", "WFC", "BNPQY")
getSymbols(Symbols=symbols, auto.assign=TRUE, from="2022-01-01", periodicity="daily", to="2023-04-19")



df_returns<-data.frame(index(CS),
                       "CS"=sqrt(252)*(diff(log(CS$CS.Close))),#CreditSuisse Returns
               "BAC"=sqrt(252)*(diff(log(BAC$BAC.Close))),#BankofAmerica Returns
               "BCS"=sqrt(252)*(diff(log(BCS$BCS.Close))),#Barclays Returns
               "C"=sqrt(252)*(diff(log(C$C.Close))),#Citigroup Returns
               "DB"=sqrt(252)*(diff(log(DB$DB.Close))),#DeutschBank Returns
               "HSBC"=sqrt(252)*(diff(log(HSBC$HSBC.Close))),#HSBC Returns
               "JPM"=sqrt(252)*(diff(log(JPM$JPM.Close))),#JPMorgan Returns
               "GS"=sqrt(252)*(diff(log(GS$GS.Close))),
               "MS"=sqrt(252)*(diff(log(MS$MS.Close))),
               "CRARY"=sqrt(252)*(diff(log(CRARY$CRARY.Close))), 
               "UBS"=sqrt(252)*(diff(log(UBS$UBS.Close))), 
               "SAN"=sqrt(252)*(diff(log(SAN$SAN.Close))),
               "WFC"=sqrt(252)*(diff(log(WFC$WFC.Close))),
               "BNP"=sqrt(252)*(diff(log(BNPQY$BNPQY.Close)))
               )

df_prices<-data.frame(index(CS),
                       "CS"=CS$CS.Close,#CreditSuisse Returns
                       "BAC"=BAC$BAC.Close,#BankofAmerica Returns
                       "BCS"=BCS$BCS.Close,#Barclays Returns
                       "C"=C$C.Close,#Citigroup Returns
                       "DB"=DB$DB.Close,#DeutschBank Returns
                       "HSBC"=HSBC$HSBC.Close,#HSBC Returns
                       "JPM"=JPM$JPM.Close,#JPMorgan Returns
                       "GS"=GS$GS.Close,
                       "MS"=MS$MS.Close,
                       "CRARY"=CRARY$CRARY.Close, 
                       "UBS"=UBS$UBS.Close, 
                       "SAN"=SAN$SAN.Close,
                      "WFC"=WFC$WFC.Close, 
                      "BNP"=BNPQY$BNPQY.Close)
                      
names(df_prices)<-c("Date", "CreditSuisse", 
                    "BankOfAmerica", 
                    "Barclays", 
                    "Citigroup", 
                    "DeutschBank", 
                    "HSBC", "JPMorgan", "GoldmanSachs", 
              "MorganStanley", "CreditAgricole", "UBS", "Santander", "WellsFargo", "BNPParibas")

names(df_returns)<-c("Date", "CreditSuisse", 
                    "BankOfAmerica", 
                    "Barclays", 
                    "Citigroup", 
                    "DeutschBank", 
                    "HSBC", "JPMorgan","GoldmanSachs", 
                    "MorganStanley", "CreditAgricole", "UBS", "Santander",
                    "WellsFargo", "BNPParibas")
Donnees_returns<-zoo(na.omit(df_returns[,-1]), order.by=df_returns[-1,1])


names(df_returns)<-c("Date", "CreditSuisse", 
              "BankOfAmerica", 
              "Barclays", 
              "Citigroup", 
              "DeutschBank", 
              "HSBC", "JPMorgan", "GoldmanSachs", 
              "MorganStanley", "CreditAgricole", "UBS", "Santander", "WellsFargo", "BNPParibas")
              
              
              
