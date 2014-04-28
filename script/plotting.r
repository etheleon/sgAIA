#!/usr/bin/env Rscript

fundprices = fetNamesf(read.table("funds/details/table.tsv",sep=",")[,-c(0,7)]), c("Fund","Currency","Offer.Price","Bid.Price", "Valuation.Date"))
as.Date(fundprices$Valuation.Date)
