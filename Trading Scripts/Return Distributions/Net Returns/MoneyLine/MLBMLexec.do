// OddsWarehouse.com NFL 2006-2023 Betting Data

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\cleanMLBdata.dta", clear
ssc install estout
ssc install outreg2


generate mlhomewin = (homescore > awayscore)
generate mlpush = (homescore == awayscore)


generate mlhomeopenpayout = (100/(-1*homemlopen)) * 100 + 100 if (homemlopen <0) & (mlhomewin == 1)
replace mlhomeopenpayout = (homemlopen/100) * 100 + 100 if (homemlopen>0) * (mlhomewin == 1)
replace mlhomeopenpayout = 0 if mlhomewin == 0 
replace mlhomeopenpayout = 100 if mlpush == 1

generate mlhomeclosepayout = (100/(-1*homemlclose)) * 100 + 100 if (homemlclose <0) & (mlhomewin == 1)
replace mlhomeclosepayout = (homemlclose/100) * 100 + 100 if (homemlclose>0) * (mlhomewin == 1)
replace mlhomeclosepayout = 0 if mlhomewin == 0 
replace mlhomeclosepayout = 100 if mlpush == 1

generate mlawayopenpayout = (100/(-1*awaymlopen)) * 100 + 100 if (awaymlopen <0) & (mlhomewin == 0)
replace mlawayopenpayout = (awaymlopen/100) * 100 + 100 if (awaymlopen>0) * (mlhomewin == 0)
replace mlawayopenpayout = 0 if mlhomewin == 1 
replace mlawayopenpayout = 100 if mlpush == 1

generate mlawayclosepayout = (100/(-1*awaymlclose)) * 100 + 100 if (awaymlclose <0) & (mlhomewin == 0)
replace mlawayclosepayout = (awaymlclose/100) * 100 + 100 if (awaymlclose>0) * (mlhomewin == 0)
replace mlawayclosepayout = 0 if mlhomewin == 1 
replace mlawayclosepayout = 100 if mlpush == 1

generate mlhomeopenreturn = (mlhomeopenpayout -100) / 100
generate mlhomeclosereturn = (mlhomeclosepayout -100) / 100

generate mlhomeOCreturn = mlhomeopenreturn - mlhomeclosereturn

generate mlawayopenreturn = (mlawayopenpayout -100) / 100
generate mlawayclosereturn = (mlawayclosepayout -100) / 100

generate mlawayOCreturn = mlawayopenreturn - mlawayclosereturn

keep gameid mlhomeOCreturn mlhomeclosereturn mlawayclosereturn mlawayOCreturn

stack gameid mlhomeclosereturn mlhomeOCreturn gameid  mlawayclosereturn mlawayOCreturn, into(gameid mlclosereturn mlOCreturn) clear

summarize

save MLBMoneylineReturn, replace