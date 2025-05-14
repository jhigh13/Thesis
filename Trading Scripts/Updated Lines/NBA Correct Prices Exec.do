// OddsWarehouse.com NFL 2006-2023 Betting Data

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\myNBAdata.dta", clear

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
replace test = (homespreadopenodds-200) - (20 * homespreadmove) if awayspreadopen > 0 & homespreadclose < 0 & homespreadopenodds > 0

replace test = (homespreadopenodds + 200) - (20 * homespreadmove) if homespreadopen < 0 & homespreadclose > 0 & homespreadopenodds < 0
replace test = homespreadopenodds - (20 * homespreadmove) if homespreadopen < 0 & homespreadclose > 0 & homespreadopenodds > 0

replace test = homespreadopenodds if homespreadmove == 0

drop if test == .

replace homespreadcloseodds = test
drop awayspreadmove homespreadmove test

save myNBAdataLines, replace