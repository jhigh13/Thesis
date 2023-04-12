// OddsWarehouse.com NBA 2006-2023 Betting Data

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\myNBAdata.dta", clear
ssc install outreg2

summarize
// Find and display summary statistics for 2 main contracts  
keep homespreadclose overclose
rename homespreadclose PointSpread
rename overclose OverUnder
order PointSpread OverUnder
format PointSpread OverUnder %12.1f

save summaryNBAdata, replace

summarize, format


outreg2 using NBAresults , word replace sum(detail) title(Summary Statistics) eqkeep(mean sd p1 p10 p25 p50 p75 p90 p99) dec(1)
