library(readxl)
pl <- read_excel("C:/Users/ahfgc/OneDrive/Desktop/DS_dataset/premier-player-23-24 - Copy.xlsx")
head(pl)
str(pl)
colSums(is.na(pl))
pl$Age[is.na(pl$Age)] <- mean(pl$Age, na.rm = TRUE)
pl <- pl[!is.na(pl$MP), ]
pl <- pl[!is.na(pl$Ast), ]
boxplot(pl$Age, main="Age (After removing Outliers)")
boxplot(pl$MP, main="Minutes Played (After removing Outliers)")
subset(pl, Age < 15 | Age > 45)
subset(pl, MP < 0)
pl <- pl[!(pl$Age < 15 | pl$Age > 45), ]
pl <- pl[pl$MP >= 0, ]
sum(duplicated(pl))
pl <- pl[!duplicated(pl), ]
invalid_pos <- pl[!(pl$Pos %in% c("FW","MF","DF","GK","FW,MF","MF,FW","MF,DF","DF,FW","FW,DF","DF,MF")), ]
invalid_pos
pl$Pos[pl$Pos == "midfielder"] <- "MF"
pl$Pos <- as.factor(pl$Pos)
class(pl$Pos)
levels(pl$Pos)
pl$AgeGroup <- cut(
  pl$Age,
  breaks = c(0, 23, 30, 40),
  labels = c("Young", "Prime", "Veteran"),
  right = TRUE
)
levels(pl$AgeGroup)
pl$MP_norm <- (pl$MP - min(pl$MP)) / (max(pl$MP) - min(pl$MP))
pl$xG_norm  <- (pl$xG - min(pl$xG)) / (max(pl$xG) - min(pl$xG))
pl$xAG_norm <- (pl$xAG - min(pl$xAG)) / (max(pl$xAG) - min(pl$xAG))
high_minutes <- pl[pl$MP > 2000, ]
forwards <- pl[pl$Pos == "FW", ]
prime_players <- pl[pl$Age >= 23 & pl$Age <= 28, ]
head(pl[, c("MP", "MP_norm")])
head(pl[, c("xG", "xG_norm")])
head(pl[, c("xAG", "xAG_norm")])
nrow(high_minutes)
head(high_minutes)
nrow(prime_players)
head(prime_players)
nrow(forwards)
head(forwards)
write.csv(pl, "cleaned_premier_league_data.csv", row.names = FALSE)
install.packages("openxlsx")
library(openxlsx)
write.xlsx(pl, "cleaned_premier_league_data.xlsx", rowNames = FALSE)
getwd()
list.files()
