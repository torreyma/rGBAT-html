#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1]
output_file <- args[2]
column_name <- args[3]

# Read the CSV file
data <- read.csv(input_file, stringsAsFactors = FALSE)

# Make sure the column exists
if (!(column_name %in% names(data))) {
  stop(paste("Column", column_name, "not found in CSV."))
}

# Simulate some processing: Add dummy Latitude and Longitude
n <- nrow(data)
set.seed(123)  # for reproducibility
data$Latitude <- round(runif(n, min = -90, max = 90), 6)
data$Longitude <- round(runif(n, min = -180, max = 180), 6)

# Write processed file
write.csv(data, output_file, row.names = FALSE)
