reg Leverage ESG_Score Asset_Growth Sales_Growth i.Industry_Code i.Year
est store POLS

reg Leverage ESG_Score Asset_Growth Sales_Growth i.FirmID i.Year
testparm i.FirmID

xtreg Leverage ESG_Score Asset_Growth Sales_Growth i.Year, fe
est store FE

xtreg Leverage ESG_Score Asset_Growth Sales_Growth i.Industry_Code i.Year, re
est store RE

hausman FE RE, sigmamore