use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\mydata.dta", clear
ssc install estout
ssc install outreg2
keep HomeOddsClose HomeLineClose TotalScoreClose
rename HomeOddsClose EuroMoneyline
gen Moneyline = cond(EuroMoneyline >= 2.0, (EuroMoneyline-1)*100, -100/(EuroMoneyline-1))
rename HomeLineClose PointSpread
// rename HomeLineOddsClose PointSpreadOdds
rename TotalScoreClose OverUnder
drop EuroMoneyline
order PointSpread Moneyline OverUnder
save cleandata, replace

//estpost summarize PointSpread Moneyline OverUnder, detail

estpost tabstat PointSpread Moneyline OverUnder, stat(mean  sd p1 p10 p25 p50 p75 p90 p99) col(stat) 
esttab ., cells("mean sd p1 p10 p25 p50 p75 p90 p99")

//format(%9.1f)




outreg2 using results, word replace sum(detail) eqkeep(mean sd p1 p10 p25 p50 p75 p90 p99), 