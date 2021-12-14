library(tidyverse)

word_list <- read.csv(paste0("https://raw.githubusercontent.com/dwyl",
                             "/english-words/master/words_alpha.txt"),
                      col.names = "word")
word_list <- word_list %>% mutate(length = str_length(word)) %>% 
                filter(length >= 4)

center_letter <- "a"
lets <- c("d", "m", "c", "t", "i", "o")
rm_lets <- letters %>% subset(!letters %in% lets & !letters %in% center_letter)

answers <- word_list %>% filter(str_detect(word, center_letter) == TRUE) %>% 
  filter(str_detect(string=word, pattern=str_c(rm_lets, collapse="|")) == FALSE)

count(answers)
answers

all_letters <- paste0(str_c(lets, collapse = ""), center_letter)

pangrams <- word_list %>% filter(str_detect(word, center_letter) == TRUE) %>%
  str_detect(string=word, pattern=all_letters)
