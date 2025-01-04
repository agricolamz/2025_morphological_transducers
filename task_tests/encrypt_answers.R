library(tidyverse)

files <- list.files("task_tests", pattern = "_decrypted.txt", full.names = TRUE)

walk(files, function(file){
  safer::encrypt_file(infile = file, 
                      key = "2025_morphological_transducers", 
                      outfile = str_replace(file, "decrypted.txt", "encrypted.bin"))
})
