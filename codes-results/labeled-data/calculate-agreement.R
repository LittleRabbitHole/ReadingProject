file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/labeled-data/dataset-task1-hung.csv"
hung.data = read.csv(file)
dim(hung.data)
file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/labeled-data/dataset-task1-ang.csv"
ang.data = read.csv(file)
dim(ang.data)
sum(hung.data$abnormal)
sum(ang.data$abnormal)
matchedlabel.data = as.data.frame(cbind(hung.data$abnormal, ang.data$abnormal,hung.data$abnormal==ang.data$abnormal))
agreement = sum(matchedlabel.data$V3,na.rm = TRUE)/nrow(matchedlabel.data)
agreement                  
