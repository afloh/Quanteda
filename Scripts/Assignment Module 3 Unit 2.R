# Load packages ----
library(quanteda)
library(tidyverse)
library(quanteda.textstats)
library(ggrepel)

print(data_corpus_inaugural)


# Data cleaning ----

toks <- tokens(data_corpus_inaugural, remove_punct = TRUE) %>%
  tokens_remove(pattern = stopwords("en")) %>%
  tokens_tolower() %>% 
  tokens_wordstem()

print(toks)

dfmat <- dfm(toks)

class(dfmat)

print(dfmat)

# Summary statistics ----
summary(data_corpus_inaugural)

summary(dfmat)

print(ntype(dfmat))
dfmat %>% ntype ()

print(ntoken(dfmat))

print(topfeatures(dfmat))

print(head(textstat_frequency(dfmat), n = 10))

topfeatures(dfmat, n = 6, groups = President) %>%
  head(n = 5) %>%
  print()

dfmat %>%
  head(n = 10) %>%
  textstat_frequency(n = 6, groups = President) %>%
  print()

tstat_ld <- textstat_lexdiv(dfmat)
head(tstat_ld)

tstat_ld %>%
  arrange(desc(TTR))
