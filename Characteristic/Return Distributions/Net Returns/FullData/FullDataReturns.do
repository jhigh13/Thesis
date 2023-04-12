use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\NFLReturnsData.dta"
append using "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\NBAReturnsData.dta"
append using "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\MLBReturnsData.dta"
append using "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\NHLReturnsData.dta"
ssc install outreg2

save FullData, replace

summarize

regress spreadclosereturn spreadOCreturn
estimates store Spread
regress mlclosereturn mlOCreturn
estimates store Moneyline
regress overclosereturn overOCreturn
estimates store OverUnder

outreg2 [Spread Moneyline OverUnder] using fulldatatab, stats(coef tstat) nodepvar nocons replace word




