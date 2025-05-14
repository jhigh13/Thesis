// OddsWarehouse.com NHL 2008-2023 Betting Data

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\myNHLdata.dta", clear
ssc install estout
ssc install outreg2

drop if awayscore == .

// Remove the juice 

// Over No Vig
generate overprobopen = 1/(1 + 100/abs(overopenodds)) if overopenodds < 0
replace overprobopen = 1/(overopenodds/100+1) if overopenodds > 0

generate overprobclose = 1/(1 + 100/abs(overcloseodds)) if overcloseodds < 0
replace overprobclose = 1/(overcloseodds/100+1) if overcloseodds > 0

generate underprobopen = 1/(1 + 100/abs(underopenodds)) if underopenodds < 0
replace underprobopen = 1/(underopenodds/100+1) if underopenodds > 0

generate underprobclose = 1/(1 + 100/abs(undercloseodds)) if undercloseodds < 0
replace underprobclose = 1/(undercloseodds/100+1) if undercloseodds > 0

generate overprobnvopen = 1/(overprobopen / (overprobopen + underprobopen) )

generate underprobnvopen = 1/(underprobopen / (overprobopen + underprobopen) )

generate overprobnvclose = 1/(overprobclose / (overprobclose + underprobclose) )

generate underprobnvclose = 1/(underprobclose / (overprobclose + underprobclose) )

replace overopenodds = (overprobnvopen - 1) * 100 if overprobnvopen >= 2
replace overopenodds = -100 / (overprobnvopen-1) if overprobnvopen <2

replace overcloseodds = (overprobnvclose - 1) * 100 if overprobnvclose >= 2
replace overcloseodds = -100 / (overprobnvclose-1) if overprobnvclose <2

replace underopenodds = (underprobnvopen - 1) * 100 if underprobnvopen >= 2
replace underopenodds = -100 / (underprobnvopen-1) if underprobnvopen <2

replace undercloseodds = (underprobnvclose - 1) * 100 if underprobnvclose >= 2
replace undercloseodds = -100 / (underprobnvclose-1) if underprobnvclose <2

// Remove Moneyline Vig

generate awaymlprobopen = 1/(1 + 100/abs(awaymlopen)) if awaymlopen < 0
replace awaymlprobopen = 1/(awaymlopen/100+1) if awaymlopen > 0

generate awaymlprobclose = 1/(1 + 100/abs(awaymlclose)) if awaymlclose < 0
replace awaymlprobclose = 1/(awaymlclose/100+1) if awaymlclose > 0

generate homemlprobopen = 1/(1 + 100/abs(homemlopen)) if homemlopen < 0
replace homemlprobopen = 1/(homemlopen/100+1) if homemlopen > 0

generate homemlprobclose = 1/(1 + 100/abs(homemlclose)) if homemlclose < 0
replace homemlprobclose = 1/(homemlclose/100+1) if homemlclose > 0

generate awaymlprobnvopen = 1/(awaymlprobopen / (awaymlprobopen + homemlprobopen) )

generate homemlprobnvopen = 1/(homemlprobopen / (awaymlprobopen + homemlprobopen) )

generate awaymlprobnvclose = 1/(awaymlprobclose / (awaymlprobclose + homemlprobclose) )

generate homemlprobnvclose = 1/(homemlprobclose / (awaymlprobclose + homemlprobclose) )

replace awaymlopen = (awaymlprobnvopen - 1) * 100 if awaymlprobnvopen >= 2
replace awaymlopen = -100 / (awaymlprobnvopen-1) if awaymlprobnvopen <2

replace awaymlclose = (awaymlprobnvclose - 1) * 100 if awaymlprobnvclose >= 2
replace awaymlclose = -100 / (awaymlprobnvclose-1) if awaymlprobnvclose <2

replace homemlopen = (homemlprobnvopen - 1) * 100 if homemlprobnvopen >= 2
replace homemlopen = -100 / (homemlprobnvopen-1) if homemlprobnvopen <2

replace homemlclose = (homemlprobnvclose - 1) * 100 if homemlprobnvclose >= 2
replace homemlclose = -100 / (homemlprobnvclose-1) if homemlprobnvclose <2

// Favorite Based Spread and Over Returns Code 

generate overopenwin = (homescore + awayscore) > (overopen)
generate overopenpush = (homescore + awayscore) == overopen

generate overclosewin = (homescore + awayscore) > (overclose)
generate overclosepush = (homescore + awayscore) == overclose

generate mlwin = 1 if (homescore > awayscore) & (homemlopen < 0)
replace mlwin = 1 if (awayscore > homescore) & (awaymlopen < 0)
replace mlwin = 0 if mlwin != 1
generate mlpush = (homescore == awayscore)

generate overopenpayout = (100/(-1*overopenodds)) * 100 + 100 if (overopenodds <0) & (overopenwin == 1)
replace overopenpayout = (overopenodds/100) * 100 + 100 if (overopenodds>0) & (overopenwin == 1)
replace overopenpayout = 0 if overopenwin == 0 
replace overopenpayout = 100 if overopenpush == 1

generate overclosepayout = (100/(-1*overcloseodds)) * 100 + 100 if (overcloseodds <0) & (overclosewin == 1)
replace overclosepayout = (overcloseodds/100) * 100 + 100 if (overcloseodds>0) & (overclosewin == 1)
replace overclosepayout = 0 if overclosewin == 0 
replace overclosepayout = 100 if overclosepush == 1

// ML 
generate mlopenpayout = (100/(-1*homemlopen)) * 100 + 100 if (homemlopen <0) & (mlwin == 1) 
replace mlopenpayout = (100/(-1*awaymlopen)) * 100 + 100 if (awaymlopen <0) & (mlwin == 1) 
replace mlopenpayout = 0 if mlwin == 0 
replace mlopenpayout = 100 if mlpush == 1

generate mlclosepayout = (100/(-1*homemlclose)) * 100 + 100 if (homemlopen <0) & (mlwin == 1) 
replace mlclosepayout = (100/(-1*awaymlclose)) * 100 + 100 if (awaymlopen <0) & (mlwin == 1) 
replace mlclosepayout = 0 if mlwin == 0 
replace mlclosepayout = 100 if mlpush == 1



generate overopenreturn = (overopenpayout -100) / 100
generate overclosereturn = (overclosepayout -100) / 100

generate overocreturn = overopenreturn - overclosereturn

generate mlopenreturn = (mlopenpayout -100) / 100
generate mlclosereturn = (mlclosepayout - 100) / 100

generate mlocreturn = mlopenreturn - mlclosereturn

drop overprobopen overprobclose underprobopen underprobclose overprobnvopen overprobnvclose underprobnvopen underprobnvclose  overopenwin overopenpush overclosewin overclosepush  overopenpayout overclosepayout awaymlprobopen awaymlprobclose homemlprobopen homemlprobclose awaymlprobnvopen homemlprobnvopen awaymlprobnvclose homemlprobnvclose mlwin mlpush mlopenpayout mlclosepayout

summarize

save NHLFavReturnsnovig, replace