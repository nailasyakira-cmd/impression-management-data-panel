*--------------------------------------------------------------------
* MODEL 1 (HASIL UTAMA)
*--------------------------------------------------------------------
xtreg Leverage ESG_Score Asset_Growth Sales_Growth i.Year, fe vce(cluster FirmID)

*--------------------------------------------------------------------
* MODEL 2 (HASIL UTAMA)
*--------------------------------------------------------------------
capture drop ESG_IM
gen ESG_IM = ESG_Score*IM_TONE

xtreg Leverage ESG_Score IM_TONE ESG_IM Asset_Growth Sales_Growth i.Year, fe vce(cluster FirmID)

*--------------------------------------------------------------------
* ROBUSTNESS CHECK (TANPA YEAR FIXED EFFECTS)
*--------------------------------------------------------------------

* Model 1 Robustness
xtreg Leverage ESG_Score Asset_Growth Sales_Growth, fe vce(cluster FirmID)

* Model 2 Robustness
xtreg Leverage ESG_Score IM_TONE ESG_IM Asset_Growth Sales_Growth, fe vce(cluster FirmID)