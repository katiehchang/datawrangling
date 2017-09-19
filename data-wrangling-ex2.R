# 0: Load the data in RStudio
library(readr)
library(tidyr)

titanic_original <- read_csv("H:/Data science/data wrangling ex2/titanic_original.csv")
View(titanic_original)

titanic <- titanic_original

# 1: Port of embarkation - replace missing values with S
titanic$embarked <- replace(titanic$embarked, is.na(titanic$embarked), "S")
titanic$embarked <- replace(titanic$embarked, titanic$embarked == "", "S")

# 2: Age - replace missing values with mean age
mean_age <- mean(titanic$age, na.rm = TRUE)
titanic$age <- replace(titanic$age, is.na(titanic$age), mean_age)
titanic$age <- replace(titanic$age, titanic$age == "", mean_age)

# 3: Lifeboat - replace missing values with NA
titanic$boat <- replace(titanic$boat, is.na(titanic$boat), "NA")
titanic$boat <- replace(titanic$boat, titanic$boat == "", "NA")

# 4: Cabin - create new column with TRUE if cabin number is listed, FALSE if NA or missing
titanic["has_cabin_number"] <- titanic$cabin != "NA"
titanic$has_cabin_number <- replace(titanic$has_cabin_number, is.na(titanic$has_cabin_number), FALSE)
titanic$has_cabin_number <- replace(titanic$has_cabin_number, titanic$has_cabin_number == "", FALSE)

View(titanic)

write_csv(titanic, "H:/Data science/data wrangling ex2/titanic_clean.csv")