est clear

capture drop ESG_IM
gen ESG_IM = ESG_Score * IM

xtreg Leverage ESG_Score i.Year, fe vce(cluster FirmID)
est store NC_H1

xtreg Leverage ESG_Score IM ESG_IM i.Year, fe vce(cluster FirmID)
est store NC_H2

xtreg Leverage ESG_Score Asset_Growth Sales_Growth i.Year, fe vce(cluster FirmID)
est store C_H1

xtreg Leverage ESG_Score IM ESG_IM Asset_Growth Sales_Growth i.Year, fe vce(cluster FirmID)
est store C_H2

capture which esttab
if _rc ssc install estout

est dir

esttab NC_H1 NC_H2 C_H1 C_H2 using "D:\SKRIPSI\Hasil_Regresi.rtf", replace ///
b(%9.4f) se(%9.4f) star(* 0.05) ///
stats(r2_w N, labels("R² Within" "Observasi")) ///
title(Hasil Regresi Data Panel)