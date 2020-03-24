library(dplyr)
files <- dir(pattern =".blast")
sets<-substr(files, 1, nchar(files)-6)
wd<-getwd()
for(file in sets){
blast <- read.delim(paste(wd, "/", file, ".blast", sep=""), header=FALSE)

colnames(blast)<-c(
  "qseqid",
  "sseqid",
  "pident",
  "length",
  "mismatch",	
  "gapopen",
  "qstart",
  "qend",
  "sstart",	 
  "send",
  "evalue",
  "bitscore")	

attach(blast)
blast.sorted<-blast[order(qseqid, -bitscore, evalue, -pident),]
blast.sorted$hsp<-paste(blast.sorted$qseqid, blast.sorted$sseqid)
blast.sorted<-blast.sorted[!(duplicated(blast.sorted$hsp)),]
detach(blast)

top3<-list()
for(query in unique(blast.sorted$qseqid)){
  data<-blast.sorted[(blast.sorted$qseqid==query),]
  top<-top_n(data, 3, row.names(data))
  top3[[(length(top3) + 1)]]=top
}

top_3<-as.data.frame(do.call("rbind", top3))
top_3$data<-paste(file)
write.csv(top_3, file=paste(sets, '.csv', sep=""))
genes<-top_3$sseqid
write.table(genes, file=paste(sets, "_genes.txt", sep=""), col.names=F, row.names = F, quote=F)
}


