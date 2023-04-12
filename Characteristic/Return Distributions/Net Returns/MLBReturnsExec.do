use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\Points\MLBPointsData.dta"
append using "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\MoneyLine\MLBMoneylineReturn.dta"

summarize

save MLBReturnsData, replace


regress mlclosereturn mlOCreturn
estimates store Moneyline
regress overclosereturn overOCreturn
estimates store OverUnder

outreg2 [Moneyline OverUnder] using fulldatatab, stats(coef) nodepvar nocons append word