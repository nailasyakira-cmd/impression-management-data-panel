library(pdftools)
library(readxl)
library(dplyr)
library(stringr)
library(writexl)

# =====================================================
# PATH
# =====================================================

mdna_folder <- "D:/SKRIPSI/output_MD&A"

dictionary_file <- "D:/SKRIPSI/Loughran-McDonald_MasterDictionary_1993-2025.xlsx"

output_file <- "D:/SKRIPSI/TONE.xlsx"

# =====================================================
# BACA KAMUS LOUGHRAN-MCDONALD
# =====================================================

dict <- read_excel(dictionary_file)

positive_words <- dict$Word[dict$Positive > 0]
negative_words <- dict$Word[dict$Negative > 0]

positive_words <- toupper(positive_words)
negative_words <- toupper(negative_words)

cat("Jumlah kata positif :", length(positive_words), "\n")
cat("Jumlah kata negatif :", length(negative_words), "\n")

# =====================================================
# DAFTAR FILE PDF MD&A
# =====================================================

pdf_files <- list.files(
  path = mdna_folder,
  pattern = "\\.pdf$",
  full.names = TRUE,
  ignore.case = TRUE
)

cat("Jumlah file MD&A :", length(pdf_files), "\n")

# =====================================================
# LOOPING HITUNG TONE
# =====================================================

hasil <- list()

for(i in seq_along(pdf_files)) {

  file_path <- pdf_files[i]

  file_name <- tools::file_path_sans_ext(
    basename(file_path)
  )

  cat("Processing :", file_name, "\n")

  tryCatch({

    text <- pdf_text(file_path)

    text <- paste(text, collapse = " ")

    text <- toupper(text)

    text <- gsub("[^A-Z ]", " ", text)

    words <- unlist(str_split(text, "\\s+"))

    words <- words[words != ""]

    positive_count <- sum(words %in% positive_words)

    negative_count <- sum(words %in% negative_words)

    total_words <- length(words)

    tone <- ifelse(
      positive_count + negative_count == 0,
      NA,
      (positive_count - negative_count) /
      (positive_count + negative_count)
    )

    split_name <- str_split(
      file_name,
      "_",
      simplify = TRUE
    )

    firm_code <- split_name[1]

    year <- as.numeric(split_name[2])

    hasil[[i]] <- data.frame(
      Firm_Code = firm_code,
      Year = year,
      Positive = positive_count,
      Negative = negative_count,
      Total_Words = total_words,
      TONE = tone
    )

  }, error = function(e){

    cat("ERROR :", file_name, "\n")

  })

}

# =====================================================
# GABUNG HASIL
# =====================================================

tone_data <- bind_rows(hasil)

tone_data <- tone_data %>%
  arrange(Firm_Code, Year)

# =====================================================
# EXPORT EXCEL
# =====================================================

write_xlsx(
  tone_data,
  output_file
)

# =====================================================
# RINGKASAN
# =====================================================

cat("\n====================================\n")
cat("SELESAI\n")
cat("Jumlah observasi :", nrow(tone_data), "\n")
cat("Output :", output_file, "\n")
cat("====================================\n")