library(tidyverse)

files <- list.files("task_tests", pattern = "_decrypted.txt", full.names = TRUE)

walk(files, function(file){
  safer::encrypt_file(infile = file, 
                      key = "", 
                      outfile = str_replace(file, "decrypted.txt", "encrypted.bin"))
})
