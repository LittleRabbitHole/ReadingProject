ir.file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/IR.csv"
ir.data = read.csv(ir.file)
dim(ir.data)
ir.data[1:3,]
hci.file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/HCI.csv"
hci.data = read.csv(hci.file)
dim(hci.data)
hci.data[1:3,]

# #mark wrong questions
ir.wrong.question.ids = c(393, 380, 350,382, 349, 351, 379, 381, 392, 394, 334, 335, 336)
wrong.questions = c (rep(0, each = nrow(ir.data)))
ir.data = cbind(ir.data, wrong.questions)
dim(ir.data)
ir.data = within(ir.data, wrong.questions[idquestions %in% ir.wrong.question.ids] <- 1)
table(ir.data$wrong.questions)
ir.data.remove.wrong.questions = ir.data[ir.data$wrong.questions==0,]
dim(ir.data.remove.wrong.questions)
write.csv(ir.data, file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/IR_17_04_08.csv",row.names=FALSE)
write.csv(ir.data.remove.wrong.questions, file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/IR_17_04_08_remove_wrong_questions.csv",row.names=FALSE)

hci.wrong.question.ids = c(41, 8, 42, 4, 5, 48)
wrong.questions = c (rep(0, each = nrow(hci.data)))
hci.data = cbind(hci.data, wrong.questions)
dim(hci.data)
hci.data = within(hci.data, wrong.questions[idquestions %in% hci.wrong.question.ids] <- 1)
table(hci.data$wrong.questions)
hci.data.remove.wrong.questions = hci.data[hci.data$wrong.questions==0,]
dim(hci.data.remove.wrong.questions)
write.csv(hci.data, file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/HCI_17_04_08.csv",row.names=FALSE)
write.csv(hci.data.remove.wrong.questions, file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/HCI_17_04_08_remove_wrong_questions.csv",row.names=FALSE)



# ir.special.question.ids = c ("349", "351", "379", "381", "392", "394")
# ir.speical.data = ir.data[ir.data$idquestions %in% ir.special.question.ids, ]
# 
#hci.special.question.ids = c ("42")

vec.ir = as.vector(sort(table(ir.data$idquestions)))
plot(vec.ir, ylab = "Numbers Of Attemps", main = "IR")

vec.hci = as.vector(sort(table(hci.data$idquestions)))
plot(vec.hci, ylab = "Numbers Of Attemps", main = "HCI")
