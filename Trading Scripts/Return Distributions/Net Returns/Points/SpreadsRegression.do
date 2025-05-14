// Spread Regression Output by League

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\Points\NFLPointsData.dta"

regress spreadclosereturn spreadOCreturn
estimates store NFL
outreg2 [NFL] using spreaddatatab, stats(coef tstat) nodepvar nocons replace word
clear 


use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\NBAReturnsData.dta"

regress spreadclosereturn spreadOCreturn
estimates store NBA
outreg2 [NBA] using spreaddatatab, stats(coef tstat) nodepvar nocons append word


