songs = read.csv("songs.csv")


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

# problem 2.2

# exclude non-numerical variables 
nonvars = c("year", "songtitle", "artistname", "songID", "artistID")
songsTrain = songsTrain[ , !(names(songsTrain) %in% nonvars) ]
songsTest = songsTest[ , !(names(songsTest) %in% nonvars) ]

songsLog1 = glm(Top10 ~ ., data=songsTrain, family=binomial)
summary(songsLog1)
