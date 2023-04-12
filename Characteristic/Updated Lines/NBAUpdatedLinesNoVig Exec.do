// OddsWarehouse.com NFL 2006-2023 Betting Data

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\myNBAdata.dta", clear


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

// Change closing odds to represents odds of original contract (away team)

generate awayspreadmove = awayspreadopen - awayspreadclose

generate test = (awayspreadopenodds + 200) + (20 * awayspreadmove) if awayspreadopen > 0 & awayspreadclose > 0 & awayspreadmove > 0 & awayspreadopenodds < 0
replace test = awayspreadopenodds + (20 * awayspreadmove) if awayspreadopen > 0 & awayspreadclose > 0 & awayspreadmove > 0 & awayspreadopenodds > 0

replace test = awayspreadopenodds + (20 * awayspreadmove) if awayspreadopen > 0 & awayspreadclose > 0 & awayspreadmove < 0 & awayspreadopenodds < 0
replace test = (awayspreadopenodds-200) + (20 * awayspreadmove) if awayspreadopen > 0 & awayspreadclose > 0 & awayspreadmove < 0 & awayspreadopenodds > 0

replace test = awayspreadopenodds - (20 * awayspreadmove) if awayspreadopen < 0 & awayspreadclose < 0 & awayspreadmove > 0 & awayspreadopenodds < 0
replace test = (awayspreadopenodds -200) - (20 * awayspreadmove) if awayspreadopen < 0 & awayspreadclose < 0 & awayspreadmove > 0 & awayspreadopenodds > 0

replace test = (awayspreadopenodds + 200) - (20 * awayspreadmove) if awayspreadopen < 0 & awayspreadclose < 0 & awayspreadmove < 0 & awayspreadopenodds < 0
replace test = awayspreadopenodds - (20 * awayspreadmove) if awayspreadopen < 0 & awayspreadclose < 0 & awayspreadmove < 0 & awayspreadopenodds > 0

replace test = awayspreadopenodds - (20 * awayspreadmove) if awayspreadopen > 0 & awayspreadclose < 0 & awayspreadopenodds < 0
replace test = (awayspreadopenodds-200) - (20 * awayspreadmove) if awayspreadopen > 0 & awayspreadclose < 0 & awayspreadopenodds > 0

replace test = (awayspreadopenodds + 200) - (20 * awayspreadmove) if awayspreadopen < 0 & awayspreadclose > 0 & awayspreadopenodds < 0
replace test = awayspreadopenodds - (20 * awayspreadmove) if awayspreadopen < 0 & awayspreadclose > 0 & awayspreadopenodds > 0

replace test = awayspreadopenodds if awayspreadmove == 0

drop if test == .

replace awayspreadcloseodds = test
drop test


generate homespreadmove = homespreadopen -homespreadclose

generate test = (homespreadopenodds + 200) + (20 * homespreadmove) if homespreadopen > 0 & homespreadclose > 0 & homespreadmove > 0 & homespreadopenodds < 0
replace test = homespreadopenodds + (20 * homespreadmove) if homespreadopen > 0 & homespreadclose > 0 & homespreadmove > 0 & homespreadopenodds > 0

replace test = homespreadopenodds + (20 * homespreadmove) if homespreadopen > 0 & homespreadclose > 0 & homespreadmove < 0 & homespreadopenodds < 0
replace test = (homespreadopenodds-200) + (20 * homespreadmove) if homespreadopen > 0 & homespreadclose > 0 & homespreadmove < 0 & homespreadopenodds > 0

replace test = homespreadopenodds - (20 * homespreadmove) if homespreadopen < 0 & homespreadclose < 0 & homespreadmove > 0 & homespreadopenodds < 0
replace test = (homespreadopenodds -200) - (20 * homespreadmove) if homespreadopen < 0 & homespreadclose < 0 & homespreadmove > 0 & homespreadopenodds > 0

replace test = (homespreadopenodds + 200) - (20 * homespreadmove) if homespreadopen < 0 & homespreadclose < 0 & homespreadmove < 0 & homespreadopenodds < 0
replace test = homespreadopenodds - (20 * homespreadmove) if homespreadopen < 0 & homespreadclose < 0 & homespreadmove < 0 & homespreadopenodds > 0

replace test = homespreadopenodds - (20 * homespreadmove) if homespreadopen > 0 & homespreadclose < 0 & homespreadopenodds < 0
replace test = (homespreadopenodds-200) - (20 * homespreadmove) if homespreadopen > 0 & homespreadclose < 0 & homespreadopenodds > 0

replace test = (homespreadopenodds + 200) - (20 * homespreadmove) if homespreadopen < 0 & homespreadclose > 0 & homespreadopenodds < 0
replace test = homespreadopenodds - (20 * homespreadmove) if homespreadopen < 0 & homespreadclose > 0 & homespreadopenodds > 0

replace test = homespreadopenodds if homespreadmove == 0

drop if test == .

replace homespreadcloseodds = test
drop awayspreadmove homespreadmove awayspreadprobopen awayspreadprobclose homespreadprobopen homespreadprobclose awayspreadprobnvopen awayspreadprobnvclose homespreadprobnvopen homespreadprobnvclose test


save myNBAUpdatedLinesNoVig, replace