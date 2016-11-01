#Intertextuality in D&C
rm(list = ls())

#Libaries
library(quanteda)
#Combine d&c data with additional data in corpus with 2 docs.
data(crude)
corpus = Corpus(VectorSource(crude))

#Text processing
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, content_transformer(removePunctuation))
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, content_transfomer(stripWhitespace))
corpus <- tm_map(corpus, content_transformer(function(x) iconv(enc2utf8(x), sub = "byte")))
corpus <- tm_map(corpus, PlainTextDocument)

corpus <- Corpus(VectorSource(corpus))
#summary(corpus)

#Set up n-gram reader
#tokenize_ngrams <- function(x, n = 1) return(rownames(as.data.frame(unclass(textcnt(x, method = "string",n = n)))))

n = 2 # for n-gram number
ngramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = n, max = n))
#ngramTokenizer <- as.list(ngramTokenizer) #not clear that this actually solves the problem, since it appears now that the resulting dtm is the same as a 1-gram dtm for both 2- and 3-grams.

#tau-based tokenizer (throws "error in simple_triplet_matrix")
#dtm <- DocumentTermMatrix(corpus, control = list(tokenize = tokenize_ngrams)) #Error message. Can't get past it.
dtm <- DocumentTermMatrix(corpus) #, control = ngramTokenizer)
dtm_2 <- DocumentTermMatrix(corpus, control = ngramTokenizer())

identical(dtm, dtm_2)

#dtm_2 still won't work. Error in lapply(x,f), argument "x" is missing, with no default.
#FWIW, it's a different error.