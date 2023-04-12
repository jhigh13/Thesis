use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\MoneyLine\MLBMoneylineReturn.dta"

regress mlclosereturn mlOCreturn
estimates store MLB
outreg2 [MLB] using mldatatab, stats(coef tstat) nodepvar nocons replace word
clear

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\MoneyLine\NFLMoneylineReturns.dta"

regress mlclosereturn mlOCreturn
estimates store NFL
outreg2 [NFL] using mldatatab, stats(coef tstat) nodepvar nocons append word
clear

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Return Distributions\Net Returns\MoneyLine\NHLMoneylineReturns.dta"

regress mlclosereturn mlOCreturn
estimates store NHL
outreg2 [NHL] using mldatatab, stats(coef tstat) nodepvar nocons append word