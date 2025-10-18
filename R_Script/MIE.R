
###################################################################################################
# 
#Title: Methane Index Explorer (MIE) – Estimating Response to Selection for Methane Emissions.
# Description: This script estimates selection responses for Methane emissions in selection indices
# under different user-defined economic values based on linear regression between traits' estimated
# breeding values.
# License: GNU GPL License v3
# R version: 4.3.0 (2023-04-21 ucrt)
#
###################################################################################################
#
# Uncomment and run if you need to install these packages
# install.packages(c("readxl", ggplot2", "dplyr", "ggpubr", "moments"))
#
# Load required libraries
library(readxl)
library(dplyr)
library(ggplot2)
library(ggpubr) # for density/QQ plot
library(moments) # for skewness & kurtosis
#
#writing log file in txt format
Flock <- "2638"
Year <- "2021"
Index <- "CH4_NZMW_plus_index"
Date <- "9-Dec-2024"
Job <- "2434492"
sink(paste0(Flock,"_",Year, "_", Index, ".txt"), split=TRUE)
#
#title for output log file
cat("\n")
cat("Potential of maximal progress for methane and the production indices")
cat("\n")
#
cat("\n")
cat("Flock: B+LNZ Genetics Flock 2638") # flock name  
cat("\n")
cat("Number of Rams: 744") # no. of rams in analysis
cat("\n")
cat("Date Job Run: 9-Dec-2024") # data extraction date 
cat("\n")
cat("Job No.: 2434492") # reference for data extraction 
cat("\n")
cat("Job Birth Period: 2021 to 2021") # birth year range of rams 
cat("\n")
cat("\n")
cat("Traits used for index") # title for the traits in selection index
cat("\n")
#
#
mean_grms_day <- 7.5 #scaled mean daily CH4 production
dollar_percent_CH4gBV <- -0.51075 #$6.81*7.5/100 #converting to dollar value 
#
#reading the economic values and estimated breeding values files 
EVs <- read_excel('EVs_MW_plus.xlsx')
data <- read_excel('2638_2022_AAABG_survived.xlsx',col_names = T)
#
#sinks the traits to log file
colnames(EVs) 
cat("\n")
cat("Economic values used for NZMW plus index traits (¢)")
cat("\n")
as.data.frame(EVs)
cat("\n")
cat("Economic values used for CH4 ($/tonne CO2e)")
cat("\n")
#
#
#estimating NZMW_plus (EVs based on index positions in EV file)
data$'NZMW_plus' <- (data$WWTgBV*EVs$WWTgBV)+(data$WWTMgBV*EVs$WWTMgBV)+(data$CWgBV*EVs$CWgBV)+
  (data$EWTgBV*EVs$EWTgBV)+(data$SURgBV*EVs$SURgBV)+(data$SURMgBV*EVs$SURMgBV)+(data$NLBgBV*EVs$NLBgBV)+
  (data$CWYgBV*EVs$CWYgBV)+(data$SHLYgBV*EVs$SHLYgBV)+(data$HQLYgBV*EVs$HQLYgBV)+(data$LNLYgBV*EVs$LNLYgBV)+
  (data$FEC1gBV*EVs$FEC1gBV)+(data$FEC2gBV*EVs$FEC2gBV)+(data$AFECgBV*EVs$AFECgBV)+
  (data$ADAGgBV*EVs$ADAGgBV)+(data$LDAGgBV*EVs$LDAGgBV)
#
#converting CH4-BV to percentage CH4-BV
data$'CH4-BV%' <- (data$PACCH4gBV)/7.5*100
#
#
#converting CH4-BV% to a $ index value (DPCH4DPCH4) & adding to the NZMW_plus index under different economic 
#values  
#DPCH4DPCH4 ($100/tonne)
data$'DPCH4($100/tonne)' <- data$'CH4-BV%'*dollar_percent_CH4gBV*100
#NZMW_plus+DPCH4 ($100/tonne)
data$'NZMW_plus+DPCH4($100/tonne)' <- data$'NZMW_plus' + data$'DPCH4($100/tonne)'
#
#DPCH4 ($25/tonne)
data$'DPCH4($25/tonne)' <- data$'CH4-BV%'*dollar_percent_CH4gBV*100*.25
#NZMW_plus+DPCH4 ($25/tonne)
data$'NZMW_plus+DPCH4($25/tonne)' <- data$'NZMW_plus' + data$'DPCH4($25/tonne)'
#
#DPCH4 ($50/tonne)
data$'DPCH4($50/tonne)' <- data$'CH4-BV%'*dollar_percent_CH4gBV*100*.5
#NZMW_plus+DPCH4 ($50/tonne)
data$'NZMW_plus+DPCH4($50/tonne)' <- data$'NZMW_plus' + data$'DPCH4($50/tonne)'
#
#DPCH4 ($200/tonne)
data$'DPCH4($200/tonne)' <- data$'CH4-BV%'*dollar_percent_CH4gBV*100*2
#NZMW_plus+DPCH4 ($200/tonne)
data$'NZMW_plus+DPCH4($200/tonne)' <- data$'NZMW_plus' + data$'DPCH4($200/tonne)'
#
#DPCH4 ($0/tonne)
data$'DPCH4($0/tonne)' <- data$'CH4-BV%'*dollar_percent_CH4gBV*100*0
#NZMW_plus+DPCH4 ($0/tonne)
data$'NZMW_plus+DPCH4($0/tonne)' <- data$'NZMW_plus' + data$'DPCH4($0/tonne)'
#
#DPCH4 ($75/tonne)
data$'DPCH4($75/tonne)' <- data$'CH4-BV%'*dollar_percent_CH4gBV*100*0.75
#NZMW_plus+DPCH4 ($75/tonne)
data$'NZMW_plus+DPCH4($75/tonne)' <- data$'NZMW_plus' + data$'DPCH4($75/tonne)'
#
#DPCH4 ($125/tonne)
data$'DPCH4($125/tonne)' <- data$'CH4-BV%'*dollar_percent_CH4gBV*100*1.25
#NZMW_plus+DPCH4 ($125/tonne)
data$'NZMW_plus+DPCH4($125/tonne)' <- data$'NZMW_plus' + data$'DPCH4($125/tonne)'
#
#DPCH4 ($150/tonne)
data$'DPCH4($150/tonne)' <- data$'CH4-BV%'*dollar_percent_CH4gBV*100*1.5
#NZMW_plus+DPCH4 ($150/tonne)
data$'NZMW_plus+DPCH4($150/tonne)' <- data$'NZMW_plus' + data$'DPCH4($150/tonne)'
#
#DPCH4 ($175/tonne)
data$'DPCH4($175/tonne)' <- data$'CH4-BV%'*dollar_percent_CH4gBV*100*1.75
#NZMW_plus+DPCH4 ($175/tonne)
data$'NZMW_plus+DPCH4($175/tonne)' <- data$'NZMW_plus' + data$'DPCH4($175/tonne)'
#
#estimating r2 between NZMW_plus & NZMW_plus+DPCH4 for each CH4 value 
model_0 <- as.data.frame((cor(data$'NZMW_plus', data$'NZMW_plus+DPCH4($0/tonne)')^2))*100
model_25 <- as.data.frame((cor(data$'NZMW_plus', data$'NZMW_plus+DPCH4($25/tonne)')^2))*100
model_100 <- as.data.frame((cor(data$'NZMW_plus', data$'NZMW_plus+DPCH4($100/tonne)')^2))*100
model_50 <- as.data.frame((cor(data$'NZMW_plus', data$'NZMW_plus+DPCH4($50/tonne)')^2))*100
model_200 <- as.data.frame((cor(data$'NZMW_plus', data$'NZMW_plus+DPCH4($200/tonne)')^2))*100
model_75 <- as.data.frame((cor(data$'NZMW_plus', data$'NZMW_plus+DPCH4($75/tonne)')^2))*100
model_125 <- as.data.frame((cor(data$'NZMW_plus', data$'NZMW_plus+DPCH4($125/tonne)')^2))*100
model_150 <- as.data.frame((cor(data$'NZMW_plus', data$'NZMW_plus+DPCH4($150/tonne)')^2))*100
model_175 <- as.data.frame((cor(data$'NZMW_plus', data$'NZMW_plus+DPCH4($175/tonne)')^2))*100
#
#estimating r2 between DPCH4 & NZMW_plus+DPCH4 for each CH4 value 
model_0_1 <- as.data.frame((cor(data$'CH4-BV%', data$'NZMW_plus')^2))*100
model_25_1 <- as.data.frame((cor(data$'DPCH4($25/tonne)', data$'NZMW_plus+DPCH4($25/tonne)')^2))*100
model_100_1 <- as.data.frame((cor(data$'DPCH4($100/tonne)', data$'NZMW_plus+DPCH4($100/tonne)')^2))*100
model_50_1 <- as.data.frame((cor(data$'DPCH4($50/tonne)', data$'NZMW_plus+DPCH4($50/tonne)')^2))*100
model_200_1 <- as.data.frame((cor(data$'DPCH4($200/tonne)', data$'NZMW_plus+DPCH4($200/tonne)')^2))*100
model_75_1 <- as.data.frame((cor(data$'DPCH4($200/tonne)', data$'NZMW_plus+DPCH4($75/tonne)')^2))*100
model_125_1 <- as.data.frame((cor(data$'DPCH4($200/tonne)', data$'NZMW_plus+DPCH4($125/tonne)')^2))*100
model_150_1 <- as.data.frame((cor(data$'DPCH4($200/tonne)', data$'NZMW_plus+DPCH4($150/tonne)')^2))*100
model_175_1 <- as.data.frame((cor(data$'DPCH4($200/tonne)', data$'NZMW_plus+DPCH4($175/tonne)')^2))*100
#
#merge the r2 files & re-name columns
require(data.table) #initialize library
r2_1 <- rbindlist(list(model_0,model_25, model_50, model_75,model_100,model_125,model_150,model_175,
                       model_200),fill=FALSE)
r2_2 <- rbindlist(list(model_0_1,model_25_1, model_50_1, model_75_1,model_100_1,model_125_1,model_150_1,
                       model_175_1,model_200_1),fill=FALSE)
r2 <- cbind(r2_1, r2_2)
r2$'$/tonne CO2e' <- c(0,25,50,75,100,125,150,175,200)
colnames(r2)[1] <- "NZMW_plus potn progress %"
colnames(r2)[2] <- "CH4 potn progress %"
#
#sink CH4 economic values to log
cat("\n")
head(r2[,3])
#
#plotting percentage progress of CH4 and NZMW_plus
ggplot()+
  geom_line(data=r2, mapping=aes(x=r2$`$/tonne CO2e`,y=r2$`NZMW_plus potn progress %`,
                                 color="r2$`NZMW_plus potn progress %`"))+
  geom_point(data=r2, mapping=aes(x=r2$`$/tonne CO2e`,y=r2$`NZMW_plus potn progress %`,
                                  color="r2$`NZMW_plus potn progress %`"))+
  geom_line(data=r2, mapping=aes(x=r2$`$/tonne CO2e`,y=r2$`CH4 potn progress %`,
                                 color="r2$`CH4 potn progress %`"))+
  geom_point(data=r2, mapping=aes(x=r2$`$/tonne CO2e`,y=r2$`CH4 potn progress %`,
                                  color="r2$`CH4 potn progress %`"))+
  scale_color_manual(name = "Legend", values = c("r2$`NZMW_plus potn progress %`" = "blue",
                                                 "r2$`CH4 potn progress %`" = "orange"),
                     labels=c("CH4 progress %","NZMW_plus index progress %"))+
  theme(legend.position=c(.2, .6),plot.title = element_text(size = 12, face = "plain"),
        axis.text=element_text(size=9),axis.title=element_text(size=10),
  legend.text=element_text(size=8))+labs(x="CH4 economic value GWP100 ($/tonne)", 
                                         y="Potential progress (%)", 
                                         title=paste0("B+LNZ Genetics Flock", "_", Flock, "_", Year), 
                                         caption = paste0("Date Job Run:", Date, "|", "Job No.:",Job))
#
#Save the plot       
file_name <- paste0("Potential progress of B+LNZ Genetics Flock", "_", Flock, "_", Year, ".png")
ggsave(file_name,width = 15, height = 10, units = "cm")
#
#Normality testing of PACCH4gBV and CH4-BV%
cat("\n")
cat("skewness of PACCH4gBV")
skewness(data$`PACCH4gBV`) 
cat("\n")
cat("kurtosis of PACCH4gBV")
kurtosis(data$`PACCH4gBV`) 
cat("\n")
shapiro.test(data$"PACCH4gBV")
cat("\n")
cat("standard deviation of PACCH4gBV")
sd(data$`PACCH4gBV`)
cat("\n")
cat("standard deviation of & CH4-BV%")
sd(data$'CH4-BV%')
cat("\n")
sink()
#
#density plot of PACCH4gBV
skewness <-skewness(data$`PACCH4gBV`)
kurtosis <-(data$`PACCH4gBV`) 
ggdensity(data$`PACCH4gBV`, main = paste0("B+LNZ Genetics Flock", "_", Flock, "_", Year),
          xlab = "PACCH4gBV",ylab = "Density",add = "mean",rug = FALSE, fill = c("#00AFBB"))+
  labs(caption = paste0("skewnes:",skewness, "|", "kurtosis:",kurtosis) , caption.text = element_text(size = 10))+
  theme(plot.title = element_text(size = 12, face = "plain"),axis.text=element_text(size=9),
        axis.title=element_text(size=10),legend.text=element_text(size=10))  
file_name <- paste0("Density plot of B+LNZ Genetics Flock", "_", Flock, "_", Year, ".png")
ggsave(file_name,width = 15, height = 10, units = "cm")
#
#
#QQ plot of PACCH4gBV
ggqqplot(data$`PACCH4gBV`,main = paste0("B+LNZ Genetics Flock", "_", Flock, "_", Year))+
  theme(plot.title = element_text(size = 12, face = "plain"),axis.text=element_text(size=9),
        axis.title=element_text(size=10),legend.text=element_text(size=10))  
file_name <- paste0("QQ plot of B+LNZ Genetics Flock", "_", Flock, "_", Year, ".png")
ggsave(file_name,width = 15, height = 10, units = "cm")
#
#
#histogram plot of PACCH4gBV
png(paste0("Histogram of B+LNZ Genetics Flock", "_", Flock, "_", Year, ".png", width=650, height=450))
hist(data$PACCH4gBV, col='steelblue',main = paste0("B+LNZ Genetics Flock", "_", Flock, "_", Year),
     xlab = "PACCH4gBV")
theme(plot.title = element_text(size = 12, face = "plain"),axis.text=element_text(size=9),
      axis.title=element_text(size=10),legend.text=element_text(size=10))  
dev.off()
#
#breeder's equation (L=generation interval & i=intensity of selection, you need to adjust L & i according 
#to your flock circumstances)
sd_pacCH4 <- (sd(data$'CH4-BV%'))
L <- (3.5+1.3)/2 # considering of L=3.5 years for females and L=1.3 years for males
i <- (2.421+1.159)/2 #selection of top 2% of males (i = 2.421) and 30% of females (i = 1.159)
per_yr <- (i/L)
#
#CH4-BV% reduction/year
r2$'CH4 pot reduction % (per year)' <- NA
r2$'CH4 pot reduction % (per year)' <- ((((r2$`CH4 potn progress %`)/100)*sd_pacCH4)*per_yr)
#
#save percentage progress of CH4 and NZMW_plus as table
write.csv(r2,paste0("B+LNZ Genetics Flock", "_", Flock, "_", Year,".csv"),quote=FALSE,row.names=FALSE)
#
#plotting per year CH4-BV% reduction
ggplot()+
  geom_line(data=r2, mapping=aes(x=r2$`$/tonne CO2e`,y=r2$`CH4 pot reduction % (per year)`,
                                 color="r2$`CH4 pot reduction % (per year)`"))+
  geom_point(data=r2, mapping=aes(x=r2$`$/tonne CO2e`,y=r2$`CH4 pot reduction % (per year)`,
                                  color="r2$`CH4 pot reduction % (per year)`"))+
  scale_color_manual(name = "Legend", values = c("r2$`CH4 pot reduction % (per year)`" = "red"),
                     labels=c("CH4 reduction per year (%)"))+
  theme(legend.position=c(.8, .2),plot.title = element_text(size = 12, face = "plain"),
        axis.text=element_text(size=9),axis.title=element_text(size=10),
        legend.text=element_text(size=10))+
  labs(x="CH4 economic value GWP100 ($/tonne)", y="Potential CH4 reduction per year (%)", 
       title=paste0("B+LNZ Genetics Flock", "_", Flock, "_", Year), 
       caption = paste0("Date Job Run:",Date, "|", "Job No.:",Job))
file_name <- paste0("PACCH4% reduction of B+LNZ Genetics Flock", "_", Flock, "_", Year, ".png")
ggsave(file_name,width = 15, height = 10, units = "cm")

