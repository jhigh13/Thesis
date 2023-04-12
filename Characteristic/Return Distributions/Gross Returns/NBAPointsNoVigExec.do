// OddsWarehouse.com NFL 2006-2023 Betting Data
// No Vig Home Focused Point Spread and Over Returns 

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\myNBAdata.dta", clear
ssc install estout
ssc install outreg2

// Remove the Juice
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

// generate awaymlprobopen = 1/(1 + 100/abs(awaymoneylineopen)) if awaymoneylineopen < 0
// replace awaymlprobopen = 1/(awaymoneylineopen/100+1) if awaymoneylineopen > 0
//
// generate awaymlprobclose = 1/(1 + 100/abs(awaymoneylineclose)) if awaymoneylineclose < 0
// replace awaymlprobclose = 1/(awaymoneylineclose/100+1) if awaymoneylineclose > 0
//
// generate homemlprobopen = 1/(1 + 100/abs(homemoneylineopen)) if homemoneylineopen < 0
// replace homemlprobopen = 1/(homemoneylineopen/100+1) if homemoneylineopen > 0
//
// generate homemlprobclose = 1/(1 + 100/abs(homemoneylineclose)) if homemoneylineclose < 0
// replace homemlprobclose = 1/(homemoneylineclose/100+1) if homemoneylineclose > 0
//
// generate awaymlprobnvopen = 1/(awaymlprobopen / (awaymlprobopen + homemlprobopen) )
//
// generate homemlprobnvopen = 1/(homemlprobopen / (awaymlprobopen + homemlprobopen) )
//
// generate awaymlprobnvclose = 1/(awaymlprobclose / (awaymlprobclose + homemlprobclose) )
//
// generate homemlprobnvclose = 1/(homemlprobclose / (awaymlprobclose + homemlprobclose) )
//
// replace awaymoneylineopen = (awaymlprobnvopen - 1) * 100 if awaymlprobnvopen >= 2
// replace awaymoneylineopen = -100 / (awaymlprobnvopen-1) if awaymlprobnvopen <2
//
// replace awaymoneylineclose = (awaymlprobnvclose - 1) * 100 if awaymlprobnvclose >= 2
// replace awaymoneylineclose = -100 / (awaymlprobnvclose-1) if awaymlprobnvclose <2
//
// replace homemoneylineopen = (homemlprobnvopen - 1) * 100 if homemlprobnvopen >= 2
// replace homemoneylineopen = -100 / (homemlprobnvopen-1) if homemlprobnvopen <2
//
// replace homemoneylineclose = (homemlprobnvclose - 1) * 100 if homemlprobnvclose >= 2
// replace homemoneylineclose = -100 / (homemlprobnvclose-1) if homemlprobnvclose <2

generate spreadopenwin = (homescore - awayscore) > (-1 * homespreadopen)
generate spreadopenpush = (homescore - awayscore) == (-1 * homespreadopen)

generate spreadclosewin = (homescore - awayscore) > (-1 * homespreadclose)
generate spreadclosepush = (homescore - awayscore) == (-1 * homespreadclose)

generate overopenwin = (homescore + awayscore) > (overopen)
generate overopenpush = (homescore + awayscore) == overopen

generate overclosewin = (homescore + awayscore) > (overclose)
generate overclosepush = (homescore + awayscore) == overclose

// generate mlhomewin = (homescore > awayscore)
// generate mlpush = (homescore == awayscore)

generate spreadopenpayout = (100/(-1*homespreadopenodds)) * 100 + 100 if (homespreadopenodds <0) & (spreadopenwin == 1)
replace spreadopenpayout = (homespreadopenodds/100) * 100 + 100 if (homespreadopenodds>0) * (spreadopenwin == 1)
replace spreadopenpayout = 0 if spreadopenwin == 0 
replace spreadopenpayout = 100 if spreadopenpush == 1

generate spreadclosepayout = (100/(-1*homespreadcloseodds)) * 100 + 100 if (homespreadcloseodds <0) & (spreadclosewin == 1)
replace spreadclosepayout = (homespreadcloseodds/100) * 100 + 100 if (homespreadcloseodds>0) * (spreadclosewin == 1)
replace spreadclosepayout = 0 if spreadclosewin == 0 
replace spreadclosepayout = 100 if spreadclosepush == 1

generate overopenpayout = (100/(-1*overopenodds)) * 100 + 100 if (overopenodds <0) & (overopenwin == 1)
replace overopenpayout = (overopenodds/100) * 100 + 100 if (overopenodds>0) * (overopenwin == 1)
replace overopenpayout = 0 if overopenwin == 0 
replace overopenpayout = 100 if overopenpush == 1

generate overclosepayout = (100/(-1*overcloseodds)) * 100 + 100 if (overcloseodds <0) & (overclosewin == 1)
replace overclosepayout = (overcloseodds/100) * 100 + 100 if (overcloseodds>0) * (overclosewin == 1)
replace overclosepayout = 0 if overclosewin == 0 
replace overclosepayout = 100 if overclosepush == 1

// generate mlhomeopenpayout = (100/(-1*homemoneylineopen)) * 100 + 100 if (homemoneylineopen <0) & (mlhomewin == 1)
// replace mlhomeopenpayout = (homemoneylineopen/100) * 100 + 100 if (homemoneylineopen>0) * (mlhomewin == 1)
// replace mlhomeopenpayout = 0 if mlhomewin == 0 
// replace mlhomeopenpayout = 100 if mlpush == 1
//
// generate mlhomeclosepayout = (100/(-1*homemoneylineclose)) * 100 + 100 if (homemoneylineclose <0) & (mlhomewin == 1)
// replace mlhomeclosepayout = (homemoneylineclose/100) * 100 + 100 if (homemoneylineclose>0) * (mlhomewin == 1)
// replace mlhomeclosepayout = 0 if mlhomewin == 0 
// replace mlhomeclosepayout = 100 if mlpush == 1
//
// generate mlawayopenpayout = (100/(-1*awaymoneylineopen)) * 100 + 100 if (awaymoneylineopen <0) & (mlhomewin == 0)
// replace mlawayopenpayout = (awaymoneylineopen/100) * 100 + 100 if (awaymoneylineopen>0) * (mlhomewin == 0)
// replace mlawayopenpayout = 0 if mlhomewin == 1 
// replace mlawayopenpayout = 100 if mlpush == 1
//
// generate mlawayclosepayout = (100/(-1*awaymoneylineclose)) * 100 + 100 if (awaymoneylineclose <0) & (mlhomewin == 0)
// replace mlawayclosepayout = (awaymoneylineclose/100) * 100 + 100 if (awaymoneylineclose>0) * (mlhomewin == 0)
// replace mlawayclosepayout = 0 if mlhomewin == 1 
// replace mlawayclosepayout = 100 if mlpush == 1

generate spreadopenreturn = (spreadopenpayout -100) / 100
generate spreadclosereturn = (spreadclosepayout - 100) / 100

generate spreadOCreturn = spreadopenreturn - spreadclosereturn

generate overopenreturn = (overopenpayout -100) / 100
generate overclosereturn = (overclosepayout -100) / 100

generate overOCreturn = overopenreturn - overclosereturn

// generate mlhomeopenreturn = (mlhomeopenpayout -100) / 100
// generate mlhomeclosereturn = (mlhomeclosepayout -100) / 100
//
// generate mlhomeOCreturn = mlhomeopenreturn - mlhomeclosereturn
//
// generate mlawayopenreturn = (mlawayopenpayout -100) / 100
// generate mlawayclosereturn = (mlawayclosepayout -100) / 100
//
// generate mlawayOCreturn = mlawayopenreturn - mlawayclosereturn
//
// generate mlclosereturn = (mlhomeclosereturn + mlawayclosereturn)/2
// generate mlOCreturn = (mlhomeOCreturn+mlawayOCreturn) / 2
//
// keep mlclosereturn mlOCreturn
//
// regress mlclosereturn mlOCreturn


keep gameid spreadopenreturn spreadOCreturn spreadclosereturn overopenreturn overOCreturn overclosereturn
summarize

save NBAPointNoVigDatagross, replace