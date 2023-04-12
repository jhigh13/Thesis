// OddsWarehouse.com NHL 2008-2023 Betting Data

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\myNHLdata.dta", clear
ssc install outreg2

summarize
// Find and display summary statistics for 2 main contracts  
keep homemlclose overclose
rename homemlclose Moneyline
rename overclose OverUnder
order Moneyline OverUnder
format Moneyline OverUnder %12.1f

save summaryNHLdata, replace

summarize, format


outreg2 using NHLresults , word replace sum(detail) title(Summary Statistics) eqkeep(mean sd p1 p10 p25 p50 p75 p90 p99) dec(1)
