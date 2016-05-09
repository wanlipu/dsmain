songs = read.csv("songs.csv")
#test


summary(songs)
str(songs)

# problem 1.1
sum(songs$year == 2010)

# problem 1.2
sum(songs$artistname == "Michael Jackson")

# problem 1.3
songs[songs$artistname == "Michael Jackson" & songs$Top10 == 1, ]

# problem 1.4
table(songs$timesignature)

# problem 1.5
songs[which.max(songs$tempo),]

# problem 2.1
songsTrain = subset(songs, songs$year <= 2009)
songsTest = subset(songs, songs$year == 2010)

# problem 2.2 and 2.3 and 2.4 and 2.5

# exclude non-numerical variables 
nonvars = c("year", "songtitle", "artistname", "songID", "artistID")
songsTrain = songsTrain[ , !(names(songsTrain) %in% nonvars) ]
songsTest = songsTest[ , !(names(songsTest) %in% nonvars) ]

songsLog1 = glm(Top10 ~ ., data=songsTrain, family=binomial)
summary(songsLog1)

# problem 3.1
cor(songsTrain[c("loudness", "energy")])

# problem 3.2 and 3.3
songsLog2 = glm(Top10 ~ . - loudness, data=songsTrain, family=binomial)
summary(songsLog2)

songsLog3 = glm(Top10 ~ . - energy, data=songsTrain, family=binomial)
summary(songsLog3)

# problem 4.1
songsTestPred3 = predict(songsLog3, newdata = songsTest, type = "response")
table(songsTest$Top10, songsTestPred3 >= 0.45)
(309 + 19) / (373)

# problem 4.2
table(songsTest$Top10)
314/373

# problem 4.3
# 19 and 5

# problem 4.4 and 4.5
19/(40+19)
309/(309+5)
