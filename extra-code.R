#Extra code

#Get text from db using book title rather than id
gen = dbGetQuery(scrip, "SELECT scripture_text FROM scriptures WHERE book_title = 'Genesis'")

#Get HB text from db using loop over book id (39 books in HB)
for (i in 1:39){
hb = dbGetQuery(scrip, "SELECT scripture_text FROM scriptures WHERE volume_id = 1 & book_id = i")
}

#Early list of KJV stopwords
scrip_stopwords = c("ye", "yea", "o", "thine", "thy")

#Remove stopwords
#Not going to do this for the time being.
dfm_d_c_gen_stop = selectFeatures(dfm_d_c_gen_1, stopwords("english"), "remove", valuetype = "regex")

