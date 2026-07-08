****************************************************
* 06_UJI_ASUMSI_KLASIK.do
****************************************************

* Pastikan panel sudah diset
capture drop FirmID
encode Firm_Code, gen(FirmID)

xtset FirmID Year

****************************************************
* 1. UJI MULTIKOLINEARITAS
****************************************************

capture drop ESG_IM
gen ESG_IM = ESG_Score * IM_TONE

reg Leverage ESG_Score IM_TONE ESG_IM Asset_Growth Sales_Growth i.Industry_Code i.Year

vif

****************************************************
* 2. UJI HETEROSKEDASTISITAS
****************************************************

xtreg Leverage ESG_Score IM_TONE ESG_IM Asset_Growth Sales_Growth i.Year, fe

xttest3

****************************************************
* 3. UJI AUTOKORELASI
****************************************************

xtserial Leverage ESG_Score IM_TONE ESG_IM Asset_Growth Sales_Growth