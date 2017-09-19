# 0: Load the data in RStudio
library(readr)
library(dplyr)
library(tidyr)

# Save in a table named products
products <- read_csv("H:/Data science/refine_original.csv")

# 1: Clean up brand names
check_name <- function(x) {
  if (grepl(".*z.*", x, ignore.case = TRUE)) { 
    x <- "akzo"
    }
  else if (grepl(".*ps$", x, ignore.case = TRUE)) {
      x <- "philips"
  }
  else if (grepl("^van.*", x, ignore.case = TRUE)) {
    x <- "van houten"
  }
  else if (grepl("^uni.*", x, ignore.case = TRUE)) {
    x <- "unilever"
  }
  return(x)
}
products$company <- sapply(products$company, check_name)

# 2: Separate product code and number
products <- separate(products, "Product code / number", c("code", "number"), sep = "-")

# 3: Add product categories
lookup_category <- function(x) {
  if (x == "p") { return("Smartphone") }
  else if (x == "v") { return("TV") }
  else if (x == "x") { return("Laptop") }
  else if (x == "q") { return("Tablet") }
  return(x)
}

products["category"] <- sapply(products$code, lookup_category)

# 4: Add full address for geocoding
products <- unite(products, address, city, country, col = "full_address", sep = ", ")

# 5: Create dummy variables for company and product category
products["company_philips"] <- products$company == "philips"
products["company_akzo"] <- products$company == "akzo"
products["company_van_houten"] <- products$company == "van houten"
products["company_unilever"] <- products$company == "unilever"

products["product_smartphone"] <- products$category == "Smartphone"
products["product_tv"] <- products$category == "TV"
products["product_laptop"] <- products$category == "Laptop"
products["product_tablet"] <- products$category == "Tablet"

View(products)

write_csv(products, "H:/Data science/refine_clean.csv")