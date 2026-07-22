clear all
cls
set more off

import excel "D:\SKRIPSI\FINAL_DATASET.xlsx", firstrow clear

* Ubah kode perusahaan menjadi ID numerik
encode Firm_Code, gen(FirmID)

* Set panel
xtset FirmID Year