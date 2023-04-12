// OddsWarehouse.com NFL 2006-2023 Betting Data

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\cleanNFLdata.dta", clear
ssc install estout
ssc install outreg2

drop if awayscore == .

// Remove the juice 
generate awayspreadprobopen = 1/(1 + 100/abs(awayspreadopenodds)) if awayspreadopenodds < 0
replace awayspreadprobopen = 1/(awayspreadopenodds/100+1) if awayspreadopenodds > 0

generate awayspreadprobclose = 1/(1 + 100/abs(awayspreadcloseodds)) if awayspreadcloseodds < 0
replace awayspreadprobclose = 1/(awayspreadcloseodds/100+1) if awayspreadcloseodds > 0

generate homespreadprobopen = 1/(1 + 100/abs(homespreadopenodds)) if homespreadopenodds < 0
replace homespreadprobopen = 1/(homespreadopenodds/100+1) if homespreadopenodds > 0

generate homespreadprobclose = 1/(1 + 100/abs(homespreadcloseodds)) if homespreadcloseodds < 0
replace homespreadprobclose = 1/(homespreadcloseodds/100+1) if homespreadcloseodds > 0

generate awayspreadprobnvopen = 1/(awayspreadprobopen / (awayspreadprobopen + homespreadprobopen) )

generate homespreadprobnvopen = 1/(homespreadprobopen / (awayspreadprobopen + homespreadprobopen) )

generate awayspreadprobnvclose = 1/(awayspreadprobclose / (awayspreadprobclose + homespreadprobclose) )

generate homespreadprobnvclose = 1/(homespreadprobclose / (awayspreadprobclose + homespreadprobclose) )

replace awayspreadopenodds = (awayspreadprobnvopen - 1) * 100 if awayspreadprobnvopen >= 2
replace awayspreadopenodds = -100 / (awayspreadprobnvopen-1) if awayspreadprobnvopen <2

replace awayspreadcloseodds = (awayspreadprobnvclose - 1) * 100 if awayspreadprobnvclose >= 2
replace awayspreadcloseodds = -100 / (awayspreadprobnvclose-1) if awayspreadprobnvclose <2

replace homespreadopenodds = (homespreadprobnvopen - 1) * 100 if homespreadprobnvopen >= 2
replace homespreadopenodds = -100 / (homespreadprobnvopen-1) if homespreadprobnvopen <2

replace homespreadcloseodds = (homespreadprobnvclose - 1) * 100 if homespreadprobnvclose >= 2
replace homespreadcloseodds = -100 / (homespreadprobnvclose-1) if homespreadprobnvclose <2

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

// Favorite Based Spread and Over Returns Code 

generate spreadopenwin = 1 if (homescore - awayscore) > (-1 * homespreadopen) & (homespreadopen < 0)
replace spreadopenwin = 1 if (awayscore - homescore) > (-1 * awayspreadopen) & (awayspreadopen < 0)
replace spreadopenwin = 0 if spreadopenwin != 1
generate spreadopenpush = (homescore - awayscore) == (-1 * homespreadopen)

generate spreadclosewin = 1 if (homescore - awayscore) > (-1 * homespreadclose) & (homespreadopen < 0)
replace spreadclosewin = 1 if (awayscore - homescore) > (-1 * awayspreadclose) & (awayspreadopen < 0)
replace spreadclosewin = 0 if spreadclosewin != 1
generate spreadclosepush = (homescore - awayscore) == (-1 * homespreadclose)

generate overopenwin = (homescore + awayscore) > (overopen)
generate overopenpush = (homescore + awayscore) == overopen

generate overclosewin = (homescore + awayscore) > (overclose)
generate overclosepush = (homescore + awayscore) == overclose

generate mlwin = 1 if (homescore > awayscore) & (homemoneylineopen < 0)
replace mlwin = 1 if (awayscore > homescore) & (awaymoneylineopen < 0)
replace mlwin = 0 if mlwin != 1
generate mlpush = (homescore == awayscore)


generate spreadopenpayout = (100/(-1*homespreadopenodds)) * 100 + 100 if (homespreadopenodds <0) & (homespreadopen < 0) & (spreadopenwin == 1) 
replace spreadopenpayout = (homespreadopenodds/100) * 100 + 100 if (homespreadopenodds>0) & (homespreadopen < 0) &(spreadopenwin == 1)
replace spreadopenpayout = (100/(-1*awayspreadopenodds)) * 100 + 100 if (awayspreadopenodds <0) & (awayspreadopen < 0) & (spreadopenwin == 1) 
replace spreadopenpayout = (awayspreadopenodds/100) * 100 + 100 if (awayspreadopenodds>0) & (awayspreadopen < 0) &(spreadopenwin == 1)
replace spreadopenpayout = 0 if spreadopenwin == 0 
replace spreadopenpayout = 100 if spreadopenpush == 1

generate spreadclosepayout = (100/(-1*homespreadcloseodds)) * 100 + 100 if (homespreadcloseodds <0) & (homespreadclose < 0) & (spreadclosewin == 1)
replace spreadclosepayout = (homespreadcloseodds/100) * 100 + 100 if (homespreadcloseodds>0) & (spreadclosewin == 1) & (homespreadclose < 0)
replace spreadclosepayout = (100/(-1*awayspreadcloseodds)) * 100 + 100 if (awayspreadcloseodds <0) & (awayspreadclose < 0) & (spreadclosewin == 1)
replace spreadclosepayout = (awayspreadcloseodds/100) * 100 + 100 if (awayspreadcloseodds>0) & (spreadclosewin == 1) & (awayspreadclose < 0)
replace spreadclosepayout = 0 if spreadclosewin == 0 
replace spreadclosepayout = 100 if spreadclosepush == 1

generate overopenpayout = (100/(-1*overopenodds)) * 100 + 100 if (overopenodds <0) & (overopenwin == 1)
replace overopenpayout = (overopenodds/100) * 100 + 100 if (overopenodds>0) & (overopenwin == 1)
replace overopenpayout = 0 if overopenwin == 0 
replace overopenpayout = 100 if overopenpush == 1

generate overclosepayout = (100/(-1*overcloseodds)) * 100 + 100 if (overcloseodds <0) & (overclosewin == 1)
replace overclosepayout = (overcloseodds/100) * 100 + 100 if (overcloseodds>0) & (overclosewin == 1)
replace overclosepayout = 0 if overclosewin == 0 
replace overclosepayout = 100 if overclosepush == 1

// ML 
generate mlopenpayout = (100/(-1*homemoneylineopen)) * 100 + 100 if (homemoneylineopen <0) & (mlwin == 1) 
replace mlopenpayout = (100/(-1*awaymoneylineopen)) * 100 + 100 if (awaymoneylineopen <0) & (mlwin == 1) 
replace mlopenpayout = 0 if mlwin == 0 
replace mlopenpayout = 100 if mlpush == 1

generate mlclosepayout = (100/(-1*homemoneylineclose)) * 100 + 100 if (homemoneylineopen <0) & (mlwin == 1) 
replace mlclosepayout = (100/(-1*awaymoneylineclose)) * 100 + 100 if (awaymoneylineopen <0) & (mlwin == 1) 
replace mlclosepayout = 0 if mlwin == 0 
replace mlclosepayout = 100 if mlpush == 1

//
generate spreadopenreturn = (spreadopenpayout -100) / 100
generate spreadclosereturn = (spreadclosepayout - 100) / 100

generate spreadocreturn = spreadopenreturn - spreadclosereturn

generate overopenreturn = (overopenpayout -100) / 100
generate overclosereturn = (overclosepayout -100) / 100

generate overocreturn = overopenreturn - overclosereturn

generate mlopenreturn = (mlopenpayout -100) / 100
generate mlclosereturn = (mlclosepayout - 100) / 100

generate mlocreturn = mlopenreturn - mlclosereturn

drop awayspreadprobopen awayspreadprobclose homespreadprobopen homespreadprobclose awayspreadprobnvopen awayspreadprobnvclose homespreadprobnvopen homespreadprobnvclose overprobopen overprobclose underprobopen underprobclose overprobnvopen overprobnvclose underprobnvopen underprobnvclose spreadopenwin spreadopenpush spreadclosewin spreadclosepush overopenwin overopenpush overclosewin overclosepush spreadopenpayout spreadclosepayout overopenpayout overclosepayout awaymlprobopen awaymlprobclose homemlprobopen homemlprobclose awaymlprobnvopen homemlprobnvopen awaymlprobnvclose homemlprobnvclose mlwin mlpush mlopenpayout mlclosepayout

summarize

save NFLFavReturnsnovig, replace