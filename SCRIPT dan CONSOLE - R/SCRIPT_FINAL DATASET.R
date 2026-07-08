library(readxl)
library(dplyr)
library(writexl)

# ======================================
# PATH
# ======================================

variabel_file <- "D:/SKRIPSI/Variabel Skripsi.xlsx"

imtone_file <- "D:/SKRIPSI/IM_TONE.xlsx"

output_file <- "D:/SKRIPSI/FINAL_DATASET.xlsx"

# ======================================
# BACA DATA
# ======================================

variabel <- read_excel(variabel_file)

imtone <- read_excel(imtone_file)

# ======================================
# AMBIL KOLOM YANG DIPERLUKAN
# ======================================

imtone_merge <- imtone %>%
  select(
    Firm_Code,
    Year,
    IM_TONE
  )

# ======================================
# MERGE
# ======================================

final_dataset <- variabel %>%
  left_join(
    imtone_merge,
    by = c("Firm_Code","Year")
  )

# ======================================
# CEK HASIL
# ======================================

cat("Jumlah observasi :", nrow(final_dataset), "\n")

cat("Jumlah IM_TONE kosong :",
    sum(is.na(final_dataset$IM_TONE)),
    "\n")

# ======================================
# EXPORT
# ======================================

write_xlsx(
  final_dataset,
  output_file
)

cat("\nSELESAI\n")
cat("Output : ", output_file, "\n")