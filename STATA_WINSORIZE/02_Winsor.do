capture which winsor2
if _rc ssc install winsor2

graph box Leverage
graph box ESG_Score
graph box IM
graph box Asset_Growth
graph box Sales_Growth

winsor2 Leverage Asset_Growth Sales_Growth, replace cuts(1 99)

save "D:\SKRIPSI\FINAL_DATASET_WINSOR.dta", replace

export excel using "D:\SKRIPSI\FINAL_DATASET_WINSOR.xlsx", firstrow(variables) replace