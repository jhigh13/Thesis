// OddsWarehouse.com NFL 2006-2023 Betting Data

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\cleanNFLdata.dta", clear
ssc install estout
ssc install outreg2

// Remove ML Vig
// Remove Moneyline Vig

generate awaymlprobopen = 1/(1 + 100/abs(awaymoneylineopen)) if awaymoneylineopen < 0
replace awaymlprobopen = 1/(awaymoneylineopen/100+1) if awaymoneylineopen > 0

generate awaymlprobclose = 1/(1 + 100/abs(awaymoneylineclose)) if awaymoneylineclose < 0
replace awaymlprobclose = 1/(awaymoneylineclose/100+1) if awaymoneylineclose > 0

generate homemlprobopen = 1/(1 + 100/abs(homemoneylineopen)) if homemoneylineopen < 0
replace homemlprobopen = 1/(homemoneylineopen/100+1) if homemoneylineopen > 0

generate homemlprobclose = 1/(1 + 100/abs(homemoneylineclose)) if homemoneylineclose < 0
replace homemlprobclose = 1/(homemoneylineclose/100+1) if homemoneylineclose > 0

generate awaymlprobnvopen = 1/(awaymlprobopen / (awaymlprobopen + homemlprobopen) )

generate homemlprobnvopen = 1/(homemlprobopen / (awaymlprobopen + homemlprobopen) )

generate awaymlprobnvclose = 1/(awaymlprobclose / (awaymlprobclose + homemlprobclose) )

generate homemlprobnvclose = 1/(homemlprobclose / (awaymlprobclose + homemlprobclose) )

replace awaymoneylineopen = (awaymlprobnvopen - 1) * 100 if awaymlprobnvopen >= 2
replace awaymoneylineopen = -100 / (awaymlprobnvopen-1) if awaymlprobnvopen <2

replace awaymoneylineclose = (awaymlprobnvclose - 1) * 100 if awaymlprobnvclose >= 2
replace awaymoneylineclose = -100 / (awaymlprobnvclose-1) if awaymlprobnvclose <2

replace homemoneylineopen = (homemlprobnvopen - 1) * 100 if homemlprobnvopen >= 2
replace homemoneylineopen = -100 / (homemlprobnvopen-1) if homemlprobnvopen <2

replace homemoneylineclose = (homemlprobnvclose - 1) * 100 if homemlprobnvclose >= 2
replace homemoneylineclose = -100 / (homemlprobnvclose-1) if homemlprobnvclose <2


// Calculate returns 
generate mlhomewin = (homescore > awayscore)
generate mlpush = (homescore == awayscore)

generate mlhomeopenpayout = (100/(-1*homemoneylineopen)) * 100 + 100 if (homemoneylineopen <0) & (mlhomewin == 1)
replace mlhomeopenpayout = (homemoneylineopen/100) * 100 + 100 if (homemoneylineopen>0) * (mlhomewin == 1)
replace mlhomeopenpayout = 0 if mlhomewin == 0 
replace mlhomeopenpayout = 100 if mlpush == 1

generate mlhomeclosepayout = (100/(-1*homemoneylineclose)) * 100 + 100 if (homemoneylineclose <0) & (mlhomewin == 1)
replace mlhomeclosepayout = (homemoneylineclose/100) * 100 + 100 if (homemoneylineclose>0) * (mlhomewin == 1)
replace mlhomeclosepayout = 0 if mlhomewin == 0 
replace mlhomeclosepayout = 100 if mlpush == 1

generate mlawayopenpayout = (100/(-1*awaymoneylineopen)) * 100 + 100 if (awaymoneylineopen <0) & (mlhomewin == 0)
replace mlawayopenpayout = (awaymoneylineopen/100) * 100 + 100 if (awaymoneylineopen>0) * (mlhomewin == 0)
replace mlawayopenpayout = 0 if mlhomewin == 1 
replace mlawayopenpayout = 100 if mlpush == 1

generate mlawayclosepayout = (100/(-1*awaymoneylineclose)) * 100 + 100 if (awaymoneylineclose <0) & (mlhomewin == 0)
replace mlawayclosepayout = (awaymoneylineclose/100) * 100 + 100 if (awaymoneylineclose>0) * (mlhomewin == 0)
replace mlawayclosepayout = 0 if mlhomewin == 1 
replace mlawayclosepayout = 100 if mlpush == 1


generate mlhomeopenreturn = (mlhomeopenpayout -100) / 100
generate mlhomeclosereturn = (mlhomeclosepayout -100) / 100

generate mlhomeOCreturn = mlhomeopenreturn - mlhomeclosereturn

generate mlawayopenreturn = (mlawayopenpayout -100) / 100
generate mlawayclosereturn = (mlawayclosepayout -100) / 100

generate mlawayOCreturn = mlawayopenreturn - mlawayclosereturn

keep gameid mlhomeOCreturn mlhomeclosereturn mlawayclosereturn mlawayOCreturn


//keep gameid spreadopenreturn spreadOCreturn spreadclosereturn overopenreturn overOCreturn overclosereturn mlhomeopenreturn   mlhomeOCreturn mlhomeclosereturn mlawayopenreturn mlawayclosereturn mlawayOCreturn   

stack gameid mlhomeclosereturn mlhomeOCreturn gameid  mlawayclosereturn mlawayOCreturn, into(gameid mlclosereturn mlOCreturn) clear


summarize

save NFLMoneylineReturnsNVgross, replace