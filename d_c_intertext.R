#Intertextuality in D&C
rm(list = ls())
setwd("/home/chris/Documents/Church, calling/lds-scriptures-3.0")

#Libaries
library(RSQLite)
library(quanteda)

#Set up DB Connection
scrip = dbConnect(SQLite(), dbname = "./sqlite3/scriptures.db")

#Get D&C Data
d_c = dbGetQuery(scrip, "SELECT scripture_text FROM scriptures WHERE volume_id = 4")
d_c = paste(as.list(d_c), collapse = "")

              #Get other data (do this on a loop or some other repetitive structure, to go through by Book of Scripture?)
#That is, Genesis, Exodus, etc rather than in large units like OT, NT, etc.
#gen = dbGetQuery(scrip, "SELECT scripture_text FROM scriptures WHERE book_title = 'Genesis'")
gen = dbGetQuery(scrip, "SELECT scripture_text FROM scriptures WHERE book_id = 1") #this is all of Genesis
#use 
#for (i in 1:39){
#hb = dbGetQuery(scrip, "SELECT scripture_text FROM scriptures WHERE volume_id = 1 & book_id = i")
#}
#to loop over all books of the bible. There are 39 books to loop over.


gen = paste(as.list(gen), collapse = "")

#Combine corpora
d_c_corp = corpus(d_c, docnames = "D&C")
#attr(d_c_corp, "names") <- "D&C"
gen_corp = corpus(gen, docnames = "Genesis")
d_c_gen_corp = d_c_corp + gen_corp

#Tokenize Corpora, remove punctuation, numbers, etc.
scrip_stopwords = c("ye", "yea", "o", "thine", "thy")

#Construct Document-Feature Matrix
#clean up this code
dfm_d_c_gen_1 = dfm(d_c_gen_corp, removeNumbers = TRUE, ngrams = 2, window = 1) 
dfm_d_c_gen_2 = dfm(d_c_gen_corp, removeNumbers = TRUE, ngrams = 2, window = 2) 

#Note: stem = TRUE generates some errors with removeNumbers.

#Remove ngrams with stopwords (need to generate list of scripture stopwords)
dfm_d_c_gen_stop = selectFeatures(dfm_d_c_gen_1, stopwords("english"), "remove", valuetype = "regex")
#use selectFeatures() to remove ngrams with stopwords.
#use View to view dfm

#Turn dfm into matrix to manipulate dfm data.
dfm_mat_1 <- as.matrix(dfm_d_c_gen_1)
props_dfm_1 <- prop.table(dfm_mat_1)
#props_dfm_1 is oddly organized. It has 2 rows and 4000+ columns. subscripting with either 
#a column number or a n-gram returns that ngram's proportion in the data for both
#Genesis and the D&C. 
#Use View() to look at the data, if necessary.
#How do I get the actual ngram values?
#try just using the ngrams command and clean up with removeFeatures

unique_ngrams_1 = rowSums(dfm_mat_1 != 0) #Get a count of unique n-grams for each corpus. 
#Note that I'll need to redo this as the current window settings mean that ngrams aren't actually unique.

#I'll need to set this up with an apply set up. And I should really clean this up and put lots of my notes in another file.
prop.test(x = props_dfm_1[,col_value], n = unique_ngrams_1) #compare with and without conf.level

#SQL to get references based on text (needs to be edited for programmatic use):
# results = dbGetQuery(scrip, paste0(
#     "SELECT scriptures.verse_title 
#     FROM scriptures 
#     WHERE scriptures.scripture_text 
#     LIKE '%", trigram, "%'
#     IF volume_id = 4 OR book_title = 'Genesis'")) 
#need to include an IF scripture is D&C or Genesis (OT)
#results will be a data frame, containing refs for both volumes.
#need to store 

