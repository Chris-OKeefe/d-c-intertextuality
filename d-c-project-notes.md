##D&C Intertextuality Notes##

1. What to do with stopwords? In the current version I don't remove them. If I do, it seems like it will mess with the data somewhat. I can certainly use adjusted ngram totals, though. See what happens with data without removing stopwords.

2. Should I actually remove ngrams that aren't present in both corpuses? It drops data, but it's not useful data anyway. Keeping these doesn't tell me anything and maybe keeps p-values super small.

#Remove ngrams if they don't occur in both documents
#dfm_d_c_gen_trim = trim(dfm_d_c_gen_stop, minDoc = 2)

3. prop.test tests for differences. I think I want to take the p-value and subtract it from 1 to get a test of similarity...

4. I need a way to get back from ngrams into the text to find where they're located. Search for w1-wildcard-w2. Need to get rid of or ignore punct, where wildcard can be empty.

5. Consider treating chapters as separate corpora? Especially within D&C? This will show me some nice cross-section variation but doesn't do a ton to show me where the actual similarities lie. Do this to provide an overview, but don't expect much more from it.

