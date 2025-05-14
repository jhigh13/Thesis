// OddsWarehouse.com NFL 2006-2023 Betting Data

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\cleanNFLdata.dta", clear
ssc install estout
ssc install outreg2

generate spreadopenwin = (homescore - awayscore) > (-1 * homespreadopen)
generate spreadopenpush = (homescore - awayscore) == (-1 * homespreadopen)

generate spreadclosewin = (homescore - awayscore) > (-1 * homespreadclose)
generate spreadclosepush = (homescore - awayscore) == (-1 * homespreadclose)

generate overopenwin = (homescore + awayscore) > (overopen)
generate overopenpush = (homescore + awayscore) == overopen

generate overclosewin = (homescore + awayscore) > (overclose)
generate overclosepush = (homescore + awayscore) == overclose

generate mlhomewin = (homescore > awayscore)
generate mlpush = (homescore == awayscore)

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

generate spreadopenreturn = (spreadopenpayout -100) / 100
generate spreadclosereturn = (spreadclosepayout - 100) / 100

generate spreadOCreturn = spreadopenreturn - spreadclosereturn

generate overopenreturn = (overopenpayout -100) / 100
generate overclosereturn = (overclosepayout -100) / 100

generate overOCreturn = overopenreturn - overclosereturn

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

save NFLMoneylineReturns, replace