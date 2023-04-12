// OddsWarehouse.com NFL 2006-2023 Betting Data

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\myNFLdata.dta", clear
ssc install estout
ssc install outreg2

drop if awayscore == "Postponed"
destring awayscore, replace
drop if awayscore == .

destring homescore, replace

destring awaymoneylineopen, replace force
drop if awaymoneylineopen == .

destring homemoneylineopen, replace

save cleanNFLdata, replace

/*
summarize
// Find and display summary statistics for 3 main contracts  
keep homemoneylineclose homespreadclose overclose
rename homemoneylineclose Moneyline
rename homespreadclose PointSpread
rename overclose OverUnder
order PointSpread Moneyline OverUnder
format PointSpread Moneyline OverUnder %12.1f

save cleanNFLdata, replace

summarize, format


outreg2 using NFLresults, word replace sum(detail) title(Summary Statistics) eqkeep(mean sd p1 p10 p25 p50 p75 p90 p99) dec(1)
*/
