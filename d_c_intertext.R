#Intertextuality in D&C
rm(list = ls())
setwd("/home/chris/Documents/Church, calling/d-c-intertextuality")

#Libaries
library(RSQLite)
library(quanteda)

#Set up DB Connection
scrip = dbConnect(SQLite(), dbname = "../lds-scriptures-3.0/sqlite3/scriptures.db")

#Get D&C Data (by chapter)
d_c_1 = dbGetQuery(scrip, "SELECT scripture_text FROM scriptures WHERE volume_id = 4 AND chapter_number == 1")
d_c_1 = paste(as.list(d_c_1), collapse = "")

#Get other data (do this on a loop or some other repetitive structure, to go through by Book of Scripture?)
#That is, Genesis, Exodus, etc rather than in large units like OT, NT, etc.

gen = dbGetQuery(scrip, "SELECT scripture_text FROM scriptures WHERE book_id = 1") #this is all of Genesis

gen = paste(as.list(gen), collapse = "")

#Combine corpora
d_c_corp = corpus(d_c_1, docnames = "D&C")
#attr(d_c_corp, "names") <- "D&C"
gen_corp = corpus(gen, docnames = "Genesis")
d_c_gen_corp = d_c_corp + gen_corp

#Tokenize Corpora, remove punctuation, numbers, etc.


#Construct Document-Feature Matrix
#clean up this code
dfm_d_c_gen = dfm(d_c_gen_corp, removeNumbers = TRUE, ngrams = 3, window = 1) 
#Note: stem = TRUE generates some errors with removeNumbers.

#Extract ngrams from dfm. Use for search to id references.
text_refs <- features(dfm_d_c_gen)

#Prob best to use SQLite to plug this back in for searching book/chapter/verse refs.

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

