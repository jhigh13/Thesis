// Over Regression Output by League

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\Points\MLBPointsData.dta"

regress overclosereturn overOCreturn
estimates store MLB
outreg2 [MLB] using overdatatab, stats(coef tstat) nodepvar nocons replace word
clear 

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\Points\NFLPointsData.dta"

regress overclosereturn overOCreturn
estimates store NFL
outreg2 [NFL] using overdatatab, stats(coef tstat) nodepvar nocons append word
clear 

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\Points\NHLPointsData.dta"

regress overclosereturn overOCreturn
estimates store NHL
outreg2 [NHL] using overdatatab, stats(coef tstat) nodepvar nocons append word
clear

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\NBAReturnsData.dta"

regress overclosereturn overOCreturn
estimates store NBA
outreg2 [NBA] using overdatatab, stats(coef tstat) nodepvar nocons append word


