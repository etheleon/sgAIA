#!/usr/bin/env Rscript
library(ggplot2)
library(scales)
dir.create("out/individual_funds")
fundprices = unique(setNames(read.table("funds/details/table.tsv",sep=",")[,-c(1,7)], c("Fund","Currency","Offer.Price","Bid.Price", "Valuation.Date")))


fundprices$Valuation.Date = as.Date(
as.character(fundprices$Valuation.Date)
,format="%m/%d/%Y")

fundprices$month = as.POSIXlt(fundprices$Valuation.Date)$mon + 1
fundprices$year = as.POSIXlt(fundprices$Valuation.Date)$year + 1900
fundprices$day= as.POSIXlt(fundprices$Valuation.Date)$mday 

#Plot1 Fund summary
ggplot(fundprices,aes(x=Fund,y=Offer.Price))+
geom_boxplot()+
geom_point(aes(color=Valuation.Date))+
theme(axis.text.x=element_text(angle = 90,hjust=1,vjust=0))
ggsave("out/fund_summaries.pdf",dpi=300)

#Plot2 PerFund 
lapply(unique(fundprices$Fund), function(x){
    ff= subset(fundprices, Fund == x)
    ggplot(ff,aes(x=Valuation.Date,y=Offer.Price))+
    geom_point()+
    geom_line()+
    scale_x_date(labels = date_format("%d/%m/%Y"))+
    labs(x="Date", y="Offer Price")+
    theme(axis.text.x=element_text(angle = 90,hjust=1,vjust=0))
    ggsave(sprintf("out/individual_funds/%s.pdf", gsub(" ","",x)),dpi=300)
})
