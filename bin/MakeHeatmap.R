#!/usr/bin/Rscript
library("getopt")
spec <- matrix( c("first", "f", 2, "character", "This is first!",

"second", "s", 1, "character", "This is second!",

"third", "t", 2, "character", "This is third!",

"k","k",2,"character","This is k!",

"out","o",2,"character", "This is out!",

"help", "h", 0, "logical", "This is Help!"),

byrow=TRUE, ncol=5) 

opt<-getopt(spec=spec)
print(opt$first)

print(opt$second)
library(pheatmap)
library(stringr)
setwd(opt$second)
df=read.csv(opt$first,header = T,sep = " ")
row.names(df)=df[,2]
df1=df[,-1]
df2=df1[,-1]
data1=df2
data1[data1=="A"]=8
data1[data1=="T"]=6
data1[data1=="C"]=4
data1[data1=="G"]=2
data1[data1=="-"]=10
data1[data1=="N"]=12
data2=apply(data1,2,as.numeric)
rownames(data2)=paste(row.names(data1))
#class=read.csv("3kclass.csv",header = T,row.names = 1)
data3=t(data2)
#write.csv(data3,"data3")
data4=as.data.frame(data3)
pdf(opt$third)
p=pheatmap(data4,
           cluster_row = T,cluster_cols = FALSE,
           show_colnames = F,show_rownames = F,
           #annotation_row = class,
           display_numbers = F,legend = F,cutree_rows = opt$k)
dev.off()
result = data4[p$tree_row$order,]
row_cluster <- cutree(p$tree_row,k=opt$k)

re=data.frame(paste(row.names(result)))
rownames(re)=re[,1]
re[,ncol(re)+1]=row_cluster[match(rownames(re),names(row_cluster))]
colnames(re)[ncol(re)]="Cluster"
write.csv(re,file = opt$out)

