file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/HCI_17_04_08_final.csv"
#file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/IR_17_04_08_final.csv"
#file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/HCI_17_04_08_remove_wrong_questions.csv"
ir.data = read.csv(file)
dim(ir.data)

#unique(ir.data$docid)
#ir.data = ir.data[ir.data$student == "aaa169",]
#dim(data.student)
# data.section.questions = data.student[!is.na(data.student$idquestions),]
# dim(data.section.questions)

#============================================
aggregate.one.section <- function(data.arg)
{
  reading.time = sum(data.arg$dura_sec, na.rm = TRUE)
  student.id = as.character(data.arg$student[1])
  nword = sum(unique(data.arg$nbwords),na.rm = TRUE)
  READ =ifelse(nword/reading.time > 9, ifelse(nword/reading.time >50,"SKIP","SHORT"), "FULL")
  #first attempt
  data.section.questions = data.arg[!is.na(data.arg$idquestions),]
  number.of.question = length(unique(data.section.questions$idquestions))
  average.attempts = nrow(data.section.questions)/number.of.question
  first.attempt.rate = 0;
  last.attempt.rate = 0;
  question.id = ""
  for(i in unique(data.section.questions$idquestions))
  {
    eachquestion = data.section.questions[data.section.questions$idquestions==i,]
    question.id = paste(question.id,i, sep = "_")
    first.attempt.rate = first.attempt.rate + as.numeric(eachquestion$correct[1])
    last.attempt.rate = last.attempt.rate + as.numeric(eachquestion$correct[nrow(eachquestion)])
  }
  first.attempt.rate = first.attempt.rate/length(unique(data.section.questions$idquestions))
  last.attempt.rate = last.attempt.rate/length(unique(data.section.questions$idquestions))
  average.attempt.rate = nrow(data.section.questions[data.section.questions$correct==1,])/nrow(data.section.questions)
  data.section.row = cbind(student.id,question.id,reading.time,nword, READ,number.of.question, average.attempts, first.attempt.rate, last.attempt.rate, average.attempt.rate)
  data.section.row
}
#===========================================
start.pos = 1
end.pos = 0
flag.1 = FALSE
flag.2 = FALSE
data.output <- data.frame(StudentID=character(), Question = character(), ReadingTime= numeric(), NumberWords =numeric(), READ = factor(), Number.Of.Question = numeric(), Attempts = numeric(), First.Attempt.Rate = numeric(), Last.Attempt.Rate = numeric(), Average.Attempt.Rate= numeric())
for(i in 1:nrow(ir.data))
{
  if(flag.1 == FALSE)
  {
    flag.1 = ifelse(is.na(ir.data[i,]$idquestions),FALSE, TRUE)
  }else{
    if(flag.2==FALSE)
    {
      flag.2 = ifelse(is.na(ir.data[i,]$idquestions),TRUE, FALSE)
    }
  }
  if(flag.1==TRUE & flag.2==TRUE)
  {
    end.pos = i - 1
    flag.1 = FALSE
    flag.2 = FALSE
    #cat(start.pos,"\t",end.pos,"\n")
    
    data.section = ir.data[start.pos:end.pos,]
    #cat(aggregate.one.section(data.section),"\n")
    #print(dim(data.section))
    
    data.output = rbind(data.output,aggregate.one.section(data.section))
    start.pos = i
  }
}

write.csv(data.output, file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/HCI_data_task1.csv",row.names=FALSE)
#write.csv(data.output, file = "/Users/ckhuit/Documents/r-work/data-mining/final-project/IR_data_task1.csv",row.names=FALSE)

#this code to check whether students revisit or not, however, not many times they revisit, so currently ignore it
# data.output = cbind(data.output, paste(data.output$student.id,data.output$V4,sep=""))
# colnames(data.output)[9] = "student.question"
# for(i in unique(data.output$student.question))
# {
#   # print(i)
#   # print(class(i))
#   data.studentperquestion = data.output[data.output$student.question==i,]
#   if(nrow(data.studentperquestion) > 1){
#     print(nrow(data.studentperquestion))
#   }
# }

