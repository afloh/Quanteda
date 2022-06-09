# Load libraries ----
library("quanteda")
library("quanteda.textmodels")
library("quanteda.textplots")
library("quanteda.textstats")
library("ggplot2")


# Explore corpus ----
print(data_corpus_moviereviews)

head(docvars(data_corpus_moviereviews))

head(summary(data_corpus_moviereviews), 20)

data_corpus_moviereviews[1] %>%
  cat()

data_corpus_moviereviews[1]

table(data_corpus_moviereviews$sentiment)

# Calculating summary statistics ----
movie_toks <- tokens(data_corpus_moviereviews, remove_punct = TRUE,) %>%
  tokens_remove(pattern = stopwords("en")) %>%
  tokens_tolower()

print(movie_toks)       

movie_dfm <- dfm(movie_toks)

pos_dfm <- dfm_subset(movie_dfm, sentiment == "pos")

neg_dfm <- dfm_subset(movie_dfm, sentiment == "neg")

print(topfeatures(neg_dfm, 15))

print(topfeatures(neg_dfm, 15))

tstat_key_movies <- textstat_keyness(movie_dfm, target = docvars(movie_dfm, "sentiment") == "pos")

head(tstat_key_movies)

tail(tstat_key_movies)

corp_pos <- corpus_subset(data_corpus_moviemreviews, sentiment == "pos")
corp_neg <- corpus_subset(data_corpus_moviemreviews, sentiment == "neg")

toks_pos <- tokens(corp_pos)  %>%  tokens_tolower()
toks_neg <- tokens(corp_neg)  %>%  tokens_tolower()

kw_movie_pos <- movie_toks %>%
  tokens_subset(sentiment == "pos") %>%
  kwic(pattern = "great")
print(head(kw_movie_pos, 15))

kw_movie_neg <- movie_toks %>%
  tokens_subset(sentiment == "neg") %>%
  kwic(pattern = "awful")

print(head(kw_movie_neg, 15))

# Visualize sumamry statistics ----
textplot_keyness(tstat_key_movies)

data_tokens_inaugural <- tokens(data_corpus_inaugural)

kw_god <- tokens_subset(data_tokens_inaugural, Year > 1970) %>%
  kwic("god", window = 3)
tail(kw_god) %>%
  print()

kw_god_bless <- tokens_subset(data_tokens_inaugural, Year > 1970) %>%
  kwic(phrase("god bless"), window = 3)
tail(kw_god_bless) %>%
  print()

textplot_xray(kw_god, kw_god_bless)

features_dfm_movie <- textstat_frequency(movie_dfm, n = 20, groups = sentiment)

# Sort by reverse frequency order
features_dfm_movie$feature <- with(features_dfm_movie, reorder(feature, -frequency))

ggplot(features_dfm_movie, aes(x = feature, y = frequency, colour = group)) +
  geom_point() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))