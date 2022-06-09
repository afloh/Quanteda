# Load packages ----
library(quanteda)
library(tidyverse)
library(quanteda.textstats)
library(ggrepel)

print(data_corpus_inaugural)


# Data cleaning ----

toks <- tokens(data_corpus_inaugural, remove_punct = TRUE) %>%
  tokens_remove(pattern = stopwords("en")) %>%
  tokens_tolower()

print(toks)

dfmat <- dfm(toks)

print(dfmat)

# Summary statistics ----
summary(data_corpus_inaugural, n = 10)

summary(dfmat)

print(ntype(dfmat))

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
  arrange(desc(TTR)) %>%
  head()

# Visualization ----
dfmat$Tokens <- ntoken(dfmat)

plot(dfmat$Year, dfmat$Tokens, 
     main = "Frequency of Tokens by Year: 1789–2021", xlab = "Year", ylab = "Tokens",
     type = "b")

plot(dfmat$Party, dfmat$Tokens, 
     main = "Frequency of Tokens by Party", 
     xlab = "Party", ylab = "Tokens")

plot(tstat_ld$TTR, type = "l", xaxt = "n", xlab = "YEAR", ylab = "TTR")
grid()
axis(side = 1, at = seq_len(nrow(tstat_ld)), labels = dfmat$Year)

ld_plot <- ggplot(tstat_ld, aes(x = dfmat$Year, y = TTR, color = dfmat$Party)) +
  geom_point()  # this indicates you want the plot to have points 

ld_plot

ld_plot <- ld_plot +
  geom_path()  # this connects the points with lines

# Note that all points would connect, not just between party if we had not 
# indicated color by party in aes() in the last step.


ld_plot

ld_plot <- ld_plot +
  geom_path()  # this connects the points with lines

# Note that all points would connect, not just between party if we had not 
# indicated color by party in aes() in the last step.


ld_plot

ld_plot +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  # theme() controls our axis text angle (45 degrees for x axis)
  geom_text(aes(label= dfmat$President), hjust = 0, vjust = 0)


ld_plot <- ld_plot +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_label_repel(aes(label = dfmat$President, color= dfmat$Party), max.overlaps = Inf)
# this allows us to label our geom points, indicated as President from our dfm
# object (not the tstat_ld data referenced in the start), color applies a unique color to each president
# max.overlaps set to infinity to ensure points are labelled even if overlapping

ld_plot


ggplot(tstat_ld, aes(x = dfmat$Year, y = TTR, color = dfmat$Party)) +
  geom_point() +  
  geom_path() +
  labs(title = "TTR by Year", 
       x = "Year of Speech", 
       y = "Type to Token Ratio", 
       color = "Party") +
  scale_x_continuous(breaks = seq(1789, 2021, 12)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_label_repel(aes(label = dfmat$President, color= dfmat$Party), max.overlaps = Inf)