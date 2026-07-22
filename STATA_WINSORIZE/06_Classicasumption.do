capture drop ESG_IM
gen ESG_IM = ESG_Score * IM

reg Leverage ESG_Score IM ESG_IM Asset_Growth Sales_Growth i.Industry_Code i.Year

vif

xtreg Leverage ESG_Score IM ESG_IM Asset_Growth Sales_Growth i.Year, fe

xttest3

xtserial Leverage ESG_Score IM ESG_IM Asset_Growth Sales_Growth