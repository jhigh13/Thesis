// OddsWarehouse.com NFL 2006-2023 Betting Data

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\cleanMLBdata.dta", clear
ssc install estout
ssc install outreg2


generate overopenwin = (homescore + awayscore) > (overopen)
generate overopenpush = (homescore + awayscore) == overopen

generate overclosewin = (homescore + awayscore) > (overclose)
generate overclosepush = (homescore + awayscore) == overclose

// generate mlwin = (homescore > awayscore)
// generate mlpush = (homescore == awayscore)

generate overopenpayout = (100/(-1*overopenodds)) * 100 + 100 if (overopenodds <0) & (overopenwin == 1)
replace overopenpayout = (overopenodds/100) * 100 + 100 if (overopenodds>0) * (overopenwin == 1)
replace overopenpayout = 0 if overopenwin == 0 
replace overopenpayout = 100 if overopenpush == 1

generate overclosepayout = (100/(-1*overcloseodds)) * 100 + 100 if (overcloseodds <0) & (overclosewin == 1)
replace overclosepayout = (overcloseodds/100) * 100 + 100 if (overcloseodds>0) * (overclosewin == 1)
replace overclosepayout = 0 if overclosewin == 0 
replace overclosepayout = 100 if overclosepush == 1

// generate mlopenpayout = (100/(-1*homemlopen)) * 100 + 100 if (homemlopen <0) & (mlwin == 1)
// replace mlopenpayout = (homemlopen/100) * 100 + 100 if (homemlopen>0) * (mlwin == 1)
// replace mlopenpayout = 0 if mlwin == 0 
// replace mlopenpayout = 100 if mlpush == 1
//
// generate mlclosepayout = (100/(-1*homemlclose)) * 100 + 100 if (homemlclose <0) & (mlwin == 1)
// replace mlclosepayout = (homemlclose/100) * 100 + 100 if (homemlclose>0) * (mlwin == 1)
// replace mlclosepayout = 0 if mlwin == 0 
// replace mlclosepayout = 100 if mlpush == 1

generate overopenreturn = (overopenpayout -100) / 100
generate overclosereturn = (overclosepayout -100) / 100

generate overOCreturn = overopenreturn - overclosereturn

// generate mlopenreturn = (mlopenpayout -100) / 100
// generate mlclosereturn = (mlclosepayout -100) / 100
//
// generate mlOCreturn = mlopenreturn - mlclosereturn

keep gameid overopenreturn overOCreturn overclosereturn 
 

summarize

save MLBPointsData, replace