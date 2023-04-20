# stringr 

install.packages(c("tidytext","wordcloud2","janeaustenr","stopwords"))


library(here)
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(janeaustenr)


# string - string are the same as characters
# anything in 

# several stirings in a vector
words_vector<-c("Apples", "Bananas","Oranges")
words_vector



### 4 Basic families of functions

# manipulation

## combine words together
paste("High temp", "low pH")

paste("High temp", "low pH", sep = "-") # adding a different separator

paste0("High temp", "low pH") #for no space in between

shapes <- c("Square", "Circle", "Triangle")
paste("My favorite shape is a", shapes) # paste for everything in the shapes vector

two_cities <- c("best", "worst")
paste("It was the", two_cities, "of times.") # can add the vector in the middle

str_length(shapes) # give the length of each character in the vector

seq_data<-c("ATCCCGTC") #string subset - give a portion of the vector
str_sub(seq_data, start = 2, end = 4) # extract the 2nd to 4th AA

str_sub(seq_data,start = 3,end = 3) <- "A" #add an character in the 3rd position
seq_data

str_dup(seq_data, times = c(2,3)) #can duplicate character, so dublicate 2x or 3times


# whitespace tools - remove white space
badtreatments <- c("High","Hight "," High","Low","Low")
badtreatments

str_trim(badtreatments) #remove whitespace from ends, but not the middle
str_trim(badtreatments, side = "left") #select side to take whitesapce from

str_pad(badtreatments, 5, side = "right") #add whitespace on position 5 in the right side so
str_pad(badtreatments, 5, side = "right",pad = "-") #can add character

#locale sensitive operations - vary in languages computer is set up with

x<-"I love R!"
str_to_upper(x) #make all upper
str_to_lower(x) #make all lower
str_to_sentence(x) # make a sentece gamer
str_to_title(x) # make title case

#Pattern Matching

data<-c("AAA", "TATA", "CTAG", "GCTT")
str_view(data,# show strings that match pattern
         pattern = "A")  #give those that have A in them
str_detect(data, pattern = "A") #see how many with pattern (return T/F) if present or not
str_detect(data, pattern = "AT")

str_locate(data, pattern = "AT") # give where in vector, it is. GIves character position in the vector too



#regex - regular expression
#allows for search for more complex

#tyoes of regular expressions

#metacharacters
# characters that mean something other than facevalue
$,[],{}
\\ = #give what i mean for it

vals<-c("a.b", "b.c","c.d")
vals

str_replace(vals, "\\." , #replace "."
            " ") # with a space

#stringr only replace the first instence of each case
vals<-c("a.b.c", "b.c.d","c.d.e")
#string, pattern, replace
str_replace(vals, "\\.", " ")
#to replace all
str_replace_all(vals, "\\.", " ")


#sequences
# sequences of characters - also have different meaning

#keep only character that match the \\
val2<-c("test 123", "test 456", "test")
str_subset(val2, "\\d")

#character class
# square brackets used to match one of characters in vector
str_count(val2, "[aeiou]") # gives how many characters in each value of the vector
str_count(val2, "[0-9]") # tells number of character

#quantifers
strings<-c("550-153-7578",
           "banana",
           "435.114.7586",
           "home: 672-442-6739")

#[2-9] pick any number that matches 2-9
#{2} 2 times of what exactly the previous
#[-.] separators can be either a - or a .
phone <- "([2-9][0-9]{2})[-.]([0-9]{3})[-.]([0-9]{4})"
str_detect(strings, phone)


([0-9]{3})[.]([0-9]{4})[.]([0-9]{2})

# remove everything but the phone number
test<-str_subset(strings, phone)
test

test %>% 
str_replace_all("\\.", "-") %>% 
  str_replace_all("\\D"," ") %>% 
  str_trim()

#Tidy text
# textmine abstracts
original_books <- austen_books() %>% # get all of Jane Austen's books
  group_by(book) %>%
  mutate(line = row_number(), # find every line
         chapter = cumsum(str_detect(text, 
                                     regex("^chapter [\\divxlc]", # count the chapters (starts with the word chapter followed by a digit or roman numeral)
                                                 ignore_case = TRUE)))) %>%  #ignore lower or uppercase
ungroup()
  head(original_books)

# textmine needs one word a row
  #eeach word is considered a token
  
  tidy_books <- original_books %>% 
    unnest_tokens(output = word, input = text)
  
# remove stopwords, works that dont mean much
   head(get_stopwords())

   cleaned_books <- tidy_books %>% 
     anti_join(get_stopwords()) # make dataframe without stopwords

# make out the most common words
   cleaned_books %>% 
     # group_by(book) # common words by book
     count(word, sort = TRUE)
   
# Dentiment analysis
   sent_word_counts <- tidy_books %>%
     #inner join with words that have negative or positive sentiments
     inner_join(get_sentiments()) %>% # only keep pos or negative words, can keep words youre looking
     count(word, sentiment, sort = TRUE) # count them
   
   
  #plot to visulize
   sent_word_counts %>% 
     filter(n>150) %>% #only words used most times
     mutate(n = ifelse(sentiment == "negative", -n, n)) %>%  #comumn so axis changes direction
     mutate(word = reorder(word, n)) %>% # sort it so it gows from largest to smallest
     ggplot(aes(word, n, fill = sentiment)) +
     geom_col() +
     coord_flip() +
     labs(y = "Contribution to sentiment")

   # Make a word cloud
   words<-cleaned_books %>%
     count(word) %>% # count all the words
     arrange(desc(n))%>% # sort the words
     slice(1:100) #take the top 100
   wordcloud2(words, shape = 'square', size=1) # make a wordcloud out of the top 100 words
   
   
   
   