
files <- list.files("data-raw", full.names=TRUE)
files <- files[grepl("\\.[rR]$", files)]
files <- files[files != "data-raw/make-all.R"]

print(files)

for (f in files) {
  cat("sourcing: ", f, "\n")
  try(source(f))
}
