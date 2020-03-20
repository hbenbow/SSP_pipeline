files <- dir(pattern =".protein.fai")
chrom<-substr(files, 1, nchar(files)-12)
all<-list()
list<-list()
for(file in chrom){
  length<-read.delim(paste(file, ".protein.fai", sep=""), header=F)
  colnames(length)<-c("Protein", "Length", "Offset", "Linebases", "LineWidth")
  signalp<-read.delim(paste(file, "_summary.signalp5", sep=""),  header=FALSE, comment.char="#")
  colnames(signalp)<-c("Protein", "Prediction", "SP", "Other", "CS.position")
  join<-merge(length, signalp)
  small<-sum(join$Length<=250)
  signal<-sum(!(join$Prediction=="OTHER"))
  both<-dim(join[(join$Length <= 250 & !(join$Prediction == "OTHER")),])[1]
  table<-cbind(file, small, signal, both)
  list[[length(list)+1]] = table
  join$Chromosome<-paste(file)
  write.csv(join, file=paste(file, "all.csv", sep=""))
  ssps<-join[(join$Length<=250),]
  ssps<-ssps[!(ssps$Prediction=="OTHER"),]
  all[[length(all)+1]]=ssps
  write.csv(ssps, file=paste(file, "ssps.csv", sep=""))
}
Together<-as.data.frame(do.call("rbind", list))
all_SSPs<-as.data.frame(do.call("rbind", all))
write.csv(Together, file="table_ssps.csv")
write.csv(all_SSPs, file="all_chromosomes_ssps.csv")
