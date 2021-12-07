setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

if(require(pacman) == FALSE) install.packages("pacman")
pacman::p_load(tidyverse, #install and load the tidyverse group of packages 
               magrittr, janitor)

read.csv("households.csv") -> households  

households %<>% clean_names() 

households %>% pivot_longer(cols = 2:25, names_to = 'date') -> h_long 

write.csv(h_long, "household.csv")

read.csv("costs.csv") -> costs  

costs %<>% clean_names() 

costs %>% pivot_longer(cols = 2:25, names_to = 'date') -> costs 

write.csv(costs, "costs.csv")

read.csv("persons.csv") -> persons  

persons %<>% clean_names() 

persons %>% pivot_longer(cols = 2:25, names_to = 'date') -> persons 

write.csv(persons, "persons.csv")

read.csv("CPP.csv") -> cpp  

cpp %<>% clean_names() 

cpp %>% pivot_longer(cols = 2:25, names_to = 'date') -> cpp 

write.csv(cpp, "CPP.csv")

read.csv("CPH.csv") -> cph  

cph %<>% clean_names() 

cph %>% pivot_longer(cols = 2:25, names_to = 'date') -> cph 

write.csv(cph, "CPH.csv")

