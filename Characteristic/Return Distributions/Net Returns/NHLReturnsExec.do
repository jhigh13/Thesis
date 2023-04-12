use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\Points\NHLPointsData.dta"
append using "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\MoneyLine\NHLMoneylineReturns.dta"

summarize

save NHLReturnsData, replace