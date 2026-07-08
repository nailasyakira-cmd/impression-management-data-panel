library(readxl)
library(pdftools)

# ==========================================
# PATH
# ==========================================

input_folder  <- "D:/SKRIPSI/input_MD&A"
excel_file    <- "D:/SKRIPSI/MD&A.xlsx"
output_folder <- "D:/SKRIPSI/output_MD&A"

# ==========================================
# BUAT FOLDER OUTPUT
# ==========================================

if (!dir.exists(output_folder)) {
  dir.create(output_folder, recursive = TRUE)
}

# ==========================================
# BACA EXCEL
# ==========================================

mdna <- read_excel(excel_file)

cat("Jumlah observasi MD&A :", nrow(mdna), "\n")

# ==========================================
# AMBIL SEMUA PDF DARI SELURUH SUBFOLDER
# ==========================================

pdf_files <- list.files(
  path = input_folder,
  recursive = TRUE,
  full.names = TRUE
)

cat("Jumlah PDF ditemukan :", length(pdf_files), "\n")

# ==========================================
# LOOPING SPLIT MD&A
# ==========================================

success <- 0
failed <- 0

for (i in 1:nrow(mdna)) {

  firm <- as.character(mdna$Firm_Code[i])
  year <- as.character(mdna$Year[i])

  start_page <- as.integer(mdna$Hal_Awal[i])
  end_page   <- as.integer(mdna$Hal_Akhir[i])

  target_name <- paste0(
    as.character(mdna$File_Pdf[i]),
    ".pdf"
  )

  match_file <- pdf_files[
    tolower(basename(pdf_files)) ==
      tolower(target_name)
  ]

  cat("\n====================================\n")
  cat("Processing :", target_name, "\n")

  if (length(match_file) == 0) {

    cat("FILE TIDAK DITEMUKAN\n")
    failed <- failed + 1
    next

  }

  pdf_path <- match_file[1]

  output_name <- paste0(
    firm,
    "_",
    year,
    "_MD&A.pdf"
  )

  output_path <- file.path(
    output_folder,
    output_name
  )

  pages <- start_page:end_page

  tryCatch({

    pdf_subset(
      input = pdf_path,
      pages = pages,
      output = output_path
    )

    cat("SUCCESS\n")
    success <- success + 1

  }, error = function(e) {

    cat("ERROR :", e$message, "\n")
    failed <<- failed + 1

  })

}

# ==========================================
# HASIL AKHIR
# ==========================================

cat("\n====================================\n")
cat("SELESAI\n")
cat("Berhasil :", success, "\n")
cat("Gagal    :", failed, "\n")
cat("Output   :", output_folder, "\n")
cat("====================================\n")