# Load libraries ----
library(quanteda)
library(tidyverse)

# Load and explore data ----
data_corpus_inaugural %>% 
  head() %>% 
  print()

data_corpus_inaugural %>% 
  docvars()

# Clean data ----
toks_split <- tokens(data_corpus_inaugural, split_hyphens = TRUE)

toks_no_punct_stop_low <- tokens (data_corpus_inaugural, remove_punct = TRUE)  %>% 
  tokens_remove(pattern = stopwords("en"))  %>% 
  tokens_tolower()

toks_no_punct_stop_low_stem <- tokens (data_corpus_inaugural, remove_punct = TRUE)  %>% 
  tokens_remove(pattern = stopwords("en"))  %>% 
  tokens_tolower()  %>% 
  tokens_wordstem()


# Create Document-Feature-Matrix ----
dfm_inaug <- toks_no_punct_stop_low  %>% dfm()

dfm_inaug_stem <- toks_no_punct_stop_low_stem  %>% dfm()


# Summarize dfm ----
print (dfm_inaug)

print (dfm_inaug_stem)

# Function topfeatures ----

topfeatures(dfm_inaug, n = 10, scheme = "count")
topfeatures(dfm_inaug, n = 10, scheme = "count", groups = Party)
topfeatures(dfm_inaug, n = 10, scheme = "count", groups = President)

topfeatures(dfm_inaug_stem, n = 10, scheme = "count")            

topfeatures(dfm_inaug, n = 10, scheme = "docfreq")
topfeatures(dfm_inaug_stem, n = 10, scheme = "docfreq")
topfeatures(dfm_inaug_stem, n = 10, scheme = "count", groups = President)
topfeatures(dfm_inaug_stem, n = 10, scheme = "count", groups = Party)
topfeatures(dfm_inaug_stem, n = 10, scheme = "count", groups = Year)
