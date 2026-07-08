****************************************************
* DO 7 - REGRESI FINAL PANEL DATA
****************************************************

est clear

****************************************************
* MODEL 1 (H1)
****************************************************

xtreg Leverage ESG_Score Asset_Growth Sales_Growth i.Year, fe vce(cluster FirmID)

est store Model1

****************************************************
* MODEL 2 (H2 - Moderasi)
****************************************************

capture drop ESG_IM
gen ESG_IM = ESG_Score * IM_TONE

xtreg Leverage ESG_Score IM_TONE ESG_IM Asset_Growth Sales_Growth i.Year, fe vce(cluster FirmID)

est store Model2

****************************************************
* INSTALL ESTTAB (JIKA BELUM ADA)
****************************************************

capture which esttab
if _rc ssc install estout

****************************************************
* CEK MODEL
****************************************************

est dir

****************************************************
* EXPORT KE WORD
****************************************************

esttab Model1 Model2 using "D:\SKRIPSI\Hasil_Regresi.rtf", replace ///
b(%9.4f) se(%9.4f) star(* 0.10 ** 0.05 *** 0.01) ///
stats(r2_w N, labels("R² Within" "Observasi")) ///
title(Hasil Regresi Data Panel)