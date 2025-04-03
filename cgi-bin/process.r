#!/usr/bin/env Rscript

# Load geocoder package:
# Use rGBAT on DOHMH Linux servers:
suppressMessages(library(rGBAT))
# But if you are on a generic Linux machine with R, install the rGBATl package. See: https://github.com/torreyma/rGBATl
	# Note that with rGBATl currently, you should install and use Geosupport 24B. Be sure to change GBAT_name in the function call.
	# Then comment the rGBAT library line above and uncomment this one:
	#suppressMessages(library(rGBATl))

# Get arguemnts from command line:
args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1]
output_file <- args[2]
address_col <- args[3]

# Read the CSV file
data_uploaded <- read.csv(input_file, stringsAsFactors = FALSE)

# Uncomment this section for testing locally line by line:
# suppressMessages(library(readr))
# input_file <- "~/Actual-NYC-addresses-test-data_restaurants.csv"
# data_uploaded <- read_csv(input_file, show_col_types = FALSE)
# output_file <- "~/processed.csv"
# address_col <- "Address"

# Check that column exists
if (!address_col %in% names(data_uploaded)) {
  stop("Address column not found.")
}

# Assume ZIP code column exists and is named exactly like this
# TODO: Need to incorporate ZIP column selection into upload scripts
# until you do, you need this next line:
zip_col <- "ZIP_CODE"
if (!zip_col %in% names(data_uploaded)) {
  stop("ZIP_CODE column is missing.")
}

# Create a unique ID to keep track of original rows
data_uploaded$u_id <- seq_len(nrow(data_uploaded))

# Set columns to retain and geocode
source_cols <- c("u_id")
geocode_fields <- c("F1E.longitude", "F1E.latitude",
		    "F1E.output.ret_code", "F1E.output.msg")

# Run the geocoder
df_gc <- GBAT.process_freeform_addresses(
  in_df = data_uploaded,
  addr_col_name = address_col,
  third_col_name = zip_col,
  source_cols = source_cols,
  geocode_fields = geocode_fields,
  third_col_type = "zip_code",
  return_type = "all",
  GBAT_name = "24D" # Change this to 24B if using rGBATl Version: 0.0.0.9000 2025-04-01
)

# Join geocoded results back to original data
df_final <- merge(data_uploaded, df_gc, by = "u_id", all.x = TRUE)

# Write processed file
write.csv(df_final, output_file, row.names = FALSE)


