library(readxl)
library(dplyr)
library(writexl)

# =====================================================
# PATH
# =====================================================

tone_file <- "D:/SKRIPSI/TONE.xlsx"

fundamental_file <- "D:/SKRIPSI/Fundamental.xlsx"

output_file <- "D:/SKRIPSI/IM_TONE.xlsx"

# =====================================================
# BACA DATA
# =====================================================

tone <- read_excel(tone_file)

fundamental <- read_excel(fundamental_file)

# =====================================================
# MERGE DATA
# =====================================================

data_merge <- tone %>%
  left_join(
    fundamental,
    by = c("Firm_Code", "Year")
  )

# =====================================================
# HAPUS OBSERVASI YANG TIDAK LENGKAP
# =====================================================

reg_data <- data_merge %>%
  filter(
    !is.na(TONE),
    !is.na(EARN),
    !is.na(SIZE),
    !is.na(BTM),
    !is.na(RET)
  )

# =====================================================
# REGRESI TONE FUNDAMENTALS
# =====================================================

tone_model <- lm(
  TONE ~ EARN + SIZE + BTM + RET,
  data = reg_data
)

# =====================================================
# HITUNG IM_TONE (RESIDUAL)
# =====================================================

reg_data$IM_TONE <- residuals(tone_model)

# =====================================================
# GABUNGKAN KEMBALI KE DATA AWAL
# =====================================================

hasil_final <- data_merge %>%
  left_join(
    reg_data %>%
      select(
        Firm_Code,
        Year,
        IM_TONE
      ),
    by = c("Firm_Code", "Year")
  )

# =====================================================
# EXPORT EXCEL
# =====================================================

write_xlsx(
  hasil_final,
  output_file
)

# =====================================================
# RINGKASAN
# =====================================================

cat("\n====================================\n")
cat("SELESAI\n")
cat("Jumlah Observasi :", nrow(hasil_final), "\n")
cat("Output :", output_file, "\n")
cat("====================================\n")

summary(tone_model)