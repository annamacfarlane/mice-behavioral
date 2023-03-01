#data<-read.csv('all-MWM.csv')
data<-read.csv('MWM_Combined.csv')
joan_index =grep("T" , data$AnimalID)
data = data [-joan_index, ]

subj_num = length(unique(data$AnimalID))
num_col =sum( unique(data$AnimalID)[1] == data$AnimalID)

table = matrix(NA, subj_num , num_col+1)
colnames( table ) = c("AnimalID" , unique(paste0(data$Stage,"_T" ,data$Time)) )
table = as.data.frame(table)

unique_ID=unique(data$AnimalID)
uniquestage = unique(data$Stage)
uniquetime =  unique(data$Time)
for (i in 1:subj_num) {
  ID = unique_ID[i]
  table$AnimalID[i] = ID
  for (stages in uniquestage) {
    for (times in uniquetime) {
      
      index = which(data$AnimalID == ID & data$Stage == stages & data$Time == times)
      if (length(index)>0){
      measure = data$Winding_numbers [index] # change to other measures 
      col_index = grep( paste0(stages,"_T",times), colnames(table)  )
      table[i,col_index] = measure
      }
    }
  }
  
  
  }

write.csv(table, '/Users/AnnaMacFarlane/Desktop/AWN_table.csv')
