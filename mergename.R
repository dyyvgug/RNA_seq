setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) 
list.files(getwd())
t = list.files(getwd(),pattern = "\\d.+[gtf].[^txt]$")
write.table(t,file = "mergelist.txt",sep = "\n",
            quote = FALSE,row.names = FALSE, col.names = FALSE)

