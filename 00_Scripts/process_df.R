# Function process_df applies some pre-processing steps on dataframe before analysis

process_df <- function(df){
  
  # Removing last 3 rows, which are total object, total size and a blank line
  df<-head(df,-3)
  colnames(df) <-c("V1")
  
  processed_df<-data.table(str_split_fixed(df$V1, " ", 2))
  processed_df<-data.table(processed_df$V1,str_split_fixed(processed_df$V2, " ", 2))
  colnames(processed_df) <- c("V1","V2","V3")
  
  #Removing the leading spaces 
  trim.leading <- function (x)  sub("^\\s+", "", x)
  processed_df$V3 <- trim.leading(processed_df$V3)
  
  processed_df<-data.table(processed_df$V1,processed_df$V2,str_split_fixed(processed_df$V3,' ', 2))
  colnames(processed_df) <- c("V1","V2","V3","V4")
  
  processed_df<-data.table(processed_df[,c(1:3)],str_split_fixed(processed_df$V4,' ', 2))
  colnames(processed_df) <- c("date","time","size","type","filename")
  
  processed_df$size <-as.numeric(processed_df$size)
  processed_df$date_time <- as.POSIXct(paste0(processed_df$date,"T",processed_df$time),format="%Y-%m-%dT%H:%M:%OS")
  
  # Extracting file extension of filename
  processed_df$file_ext <- file_ext(processed_df$filename)
  processed_df <- processed_df[,c(6,3,4,5,7)]
  
  # Number formatting : Avoid Representing in exponential notations
  options(scipen = 999)
  
  # Removing th entries with no / blank s3 path name
  pos<-which(processed_df$filename=="")
  ifelse(length(pos)>0,processed_df<-processed_df[-pos,], "")
  
  # Checking the units of size of all files (TiB, GiB, MiB, KiB, Bytes)
  unique(processed_df$type)
  
  # Files are either in  EiB,PiB, TiB, GiB, PiB,KiB or MiB. Converting all files into a uniform unit type i.e MiB
  
  pos <- which(processed_df$type=='EiB')
  ifelse(length(pos)>0,processed_df[pos,]$size <- processed_df[pos,]$size*1100000000000, "")
  ifelse(length(pos)>0,processed_df[pos,]$type <- 'MiB', "")
  
  pos <- which(processed_df$type=='PiB')
  ifelse(length(pos)>0,processed_df[pos,]$size <- processed_df[pos,]$size*1074000000, "")
  ifelse(length(pos)>0,processed_df[pos,]$type <- 'MiB', "")
  
  pos <- which(processed_df$type=='TiB')
  ifelse(length(pos)>0,processed_df[pos,]$size <- processed_df[pos,]$size*1049000, "")
  ifelse(length(pos)>0,processed_df[pos,]$type <- 'MiB', "")
  
  pos <- which(processed_df$type=='GiB')
  ifelse(length(pos)>0,processed_df[pos,]$size <- processed_df[pos,]$size*1024, "")
  ifelse(length(pos)>0,processed_df[pos,]$type <- 'MiB', "")
  
  pos <- which(processed_df$type=='KiB')
  ifelse(length(pos)>0,processed_df[pos,]$size <- processed_df[pos,]$size/1024, "")
  ifelse(length(pos)>0,processed_df[pos,]$type <- 'MiB', "")
  
  pos <- which(processed_df$type=='Bytes')
  ifelse(length(pos)>0,processed_df[pos,]$size <- processed_df[pos,]$size/1049000, "")
  ifelse(length(pos)>0,processed_df[pos,]$type <- 'MiB', "")
  
  
  
  return(processed_df)
}
