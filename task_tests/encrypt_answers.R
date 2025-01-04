library(tidyverse)

password <- ""

list.files("task_tests", pattern = "_decrypted.txt", full.names = TRUE) |> 
  walk(function(file){
    safer::encrypt_file(infile = file, 
                        key = password, 
                        outfile = str_replace(file, 
                                              "decrypted.txt", 
                                              "encrypted.bin"))
    })

list.files("task_tests", pattern = "_encrypted.bin", full.names = TRUE) |> 
  walk(function(file){
    safer::decrypt_file(infile = file, 
                        key = password, 
                        outfile = str_replace(file, 
                                              "encrypted.bin",
                                              "decrypted.txt"))
  })
