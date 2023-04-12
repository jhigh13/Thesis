// OddsWarehouse.com NFL 2006-2023 Betting Data

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\myMLBdata.dta", clear
ssc install estout
ssc install outreg2

destring awaymlopen, replace force
drop if awaymlopen == .

destring overopenodds, replace force
drop if overopenodds == .

destring homemlopen, replace 

save cleanMLBdata, replace