# Intertextuality in the Doctrine and Covenants
This project uses text analysis to identify places where the LDS Doctrine and Covenants (D&C) relies on the Hebrew Bible (HB).

The project analyzes both texts for common trigrams (prior to removing stopwords) then compares those trigrams to a corpus in order to assess their relative importance. The corpus needs to be relevant for religious texts and their unique use of the HB compared to fiction and non-fiction. This may make identifying a useful corpus challenging.

A pilot version of the code will explore the role of Genesis in the D&C by generating lists of trigrams, then I'll broaden the data to generate list of trigrams common to both the D&C and the HB.

## Skills
* Uses RSQLite interface to pull data from an SQLite database
* Uses R's text analysis tools to compare texts.

## Task List (Pilot Code)
1.  Complete and debug code for identifying trigrams
2.  Identify a relevant corpus for comparing trigrams.
3.  Create a mechanism for locating the book-chapter-verse references for both the D&C and HB texts.
3.  Identify appropriate statistical methods for comparing frequencies of trigrams in texts.
4.  Code methods in 3 and debug.

## Notes
I don't remove stopwords for the initial generation of trigrams because I expect that removing them might generate false positives in terms of similarity. Including them means that I will get more "hits" than I want in the initial list of similar trigrams, but I can use statistical methods to sort trigrams by frequency within the comparison corpus.

I'm also unsure about whether I ought to keep trigrams that are absent in both texts, although I suspect there may be some information about relative frequency in these texts (as well as in the comparative corpus) that might give me information.
