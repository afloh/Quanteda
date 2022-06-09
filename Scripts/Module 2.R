# Load packages ----
library(quanteda)
library(tidyverse)

print(data_corpus_inaugural)

head(docvars(data_corpus_inaugural))

data_corpus_inaugural %>% 
  docvars()


data_corpus_inaugural %>% 
  summary() %>% 
  head()

print(ntype(tail(data_corpus_inaugural)))
  print()

data_corpus_inaugural %>% 
  tail() %>% 
  ntype () %>% 
  print()

data_corpus_inaugural %>% 
  tail() %>% 
  ntoken () %>% 
  print()

load(url("https://quanteda.org/data/data_corpus_sotu.rda"))

data_corpus_sotu

data_corpus_sotu %>% 
  docvars()

data_corpus_sotu %>% 
  meta()

data_corpus_sotu %>% 
  meta()

toks <- tokens(data_corpus_inaugural)
print(toks)

toks_split <- tokens(data_corpus_inaugural, split_hyphens = TRUE)

toks_sum <- sum(ntoken(toks))

toks_sum

toks_split_sum <- sum(ntoken(toks_split))

toks_split_sum

toks_split_sum - toks_sum

toks_lower <- tokens_tolower(toks)

print(toks_lower)

toks_nopunct_stop <-tokens(data_corpus_inaugural, remove_punct = TRUE,) %>%
  tokens_remove(pattern = stopwords("en"))

print(toks_nopunct_stop)


toks_nopunct_stop_low <- tokens(data_corpus_inaugural, remove_punct = TRUE,) %>%
  tokens_remove(pattern = stopwords("en")) %>%
  tokens_tolower()


tokens_wordstem(toks_nopunct_stop_low)

kw_inaug <- kwic(toks, pattern = c("citizen", "america"), window = 4)
print(head(kw_inaug, 10))

kw_inaug_pp <- kwic(toks_nopunct_stop_low, pattern = c("citizen", "america"), window = 4)
print(head(kw_inaug, 10))
