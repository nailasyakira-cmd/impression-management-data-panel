*****************************************************
* 05_MODEL_SELECTION.do
*****************************************************

* Pastikan panel sudah diset
capture drop FirmID
encode Firm_Code, gen(FirmID)
xtset FirmID Year

*****************************************************
* COMMON EFFECT MODEL (Pooled OLS)
*****************************************************

reg Leverage ESG_Score Asset_Growth Sales_Growth i.Industry_Code i.Year
est store POLS

*****************************************************
* CHOW TEST (CEM vs FEM)
*****************************************************

reg Leverage ESG_Score Asset_Growth Sales_Growth i.FirmID i.Year

testparm i.FirmID

*****************************************************
* FIXED EFFECT MODEL
*****************************************************

xtreg Leverage ESG_Score Asset_Growth Sales_Growth i.Year, fe
est store FE

*****************************************************
* RANDOM EFFECT MODEL
*****************************************************

xtreg Leverage ESG_Score Asset_Growth Sales_Growth i.Industry_Code i.Year, re
est store RE

*****************************************************
* HAUSMAN TEST
*****************************************************

hausman FE RE, sigmamore