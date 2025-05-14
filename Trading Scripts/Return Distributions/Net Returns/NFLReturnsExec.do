use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\Points\NFLPointsData.dta"

append using "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\MoneyLine\NFLMoneylineReturns.dta"

summarize

ssc install outreg2

outreg2 using returns, sum(log) sideway word replace


save NFLReturnsData, replace