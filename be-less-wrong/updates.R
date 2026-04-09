# sort bibliography

library(RefManageR)

mybib <- ReadBib("./be-less-wrong/be-less-wrong.bib")

mybib <- sort(mybib, sorting = "nyt") # sort by name - year - title

WriteBib(mybib, file = "./be-less-wrong/be-less-wrong.bib")

# fix strings with Spanish accents
# because RefManageR somehow kludges them

bibliography  <- readLines("./be-less-wrong/be-less-wrong.bib")

bibliography  <- gsub(pattern = "Ignacio Mart{\\a'\\i}n-Bar{\\a'o}",
                      replace = "Ignacio Martín-Baró",
                      x = bibliography,
                      fixed = TRUE)

# bibliography  <- gsub(pattern = "Ellacur{\\a'\\i}a", 
#                       replace = "Ellacuría", 
#                       x = bibliography,
#                       fixed = TRUE)


writeLines(bibliography, con="./be-less-wrong/be-less-wrong.bib")
