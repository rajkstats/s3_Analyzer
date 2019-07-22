# Function summary_s3() generates metadata for the s3 bucket


summary_s3 <- function(df){
  
  # Total Partitions
  total_objects <- nrow(df)
  
  # Total Space
  convert_to_bytes <- function(x){
    return(x*1049000)
  } 
  
  # Convert Mib into Bytes and then print in human readable form
  total_file_size_bytes <- convert_to_bytes(sum(df$size))
  total_space <- humanReadable(total_file_size_bytes, standard="IEC")
  
  # Average File Size
  avg_file_size_bytes <- convert_to_bytes(mean(df$size))
  
  # Returns avg file size in human Readable form in IEC (International Electrotechnical Commission)
  avg_file_size <- humanReadable(avg_file_size_bytes, standard="IEC")
  
  # Unique File extensions (.gz,.json,.parquet)
  unique_extensions <- unique(df$file_ext)
  msg_unique_extensions <- paste(paste(unique_extensions, collapse=" , "))
  unique_file_extension <- length(unique_extensions)
  
  # Most Frequent extension
  
  most_frequent_extension<- function(df){
    ext<-data.table(table(df$file_ext))
    colnames(ext) <- c("ext","freq")
    pos<-which(ext$freq==max(ext$freq))
    ifelse(length(pos)> 1, msg <- paste(paste(ext[pos]$ext, collapse=" & ") , " are equally frequent"), msg <-paste0(ext[pos]$ext, " is most frequent extension"))
    return(msg)
  }
  
  mfe <-most_frequent_extension(df)
  
  file_size_name <- function(df,function_name){
    FUN <- match.fun(function_name) 
    pos<-FUN(df$size)
    file_name <- df[FUN(which(df$size==pos))]$filename
    file_size <- humanReadable(convert_to_bytes(df[FUN(which(df$size==pos))]$size),standard="IEC")
    res<-list(file_name,file_size)
    return(res)
  }
  
  
  # Largest File Size & Name
  lfs <- unlist(file_size_name(df,max))
  lfs_name <- lfs[1]
  lfs_size  <-lfs[2]
  
  # Smallest File Size & Name
  sfs <- unlist(file_size_name(df,min))
  sfs_name <- sfs[1]
  sfs_size  <-sfs[2]
  
  file_date_name <- function(df,function_name){
    FUN <- match.fun(function_name) 
    pos<-FUN(df$date_time)
    file_date <- pos
    file_name <- df[FUN(which(df$date_time==pos))]$filename
    res<-list(file_name,file_date)
    return(res)
  }
  
  # Function to convert epoch unix timestamp to datetime
  convert_epoch_to_date_time <- function(x){
    as.POSIXct(as.numeric(as.character(x)),origin="1970-01-01",tz="UTC")
    
  }
  
  # Earliest File Date & Name
  efd <- unlist(file_date_name(df,min))
  ef_name <- efd[1]
  ef_date<-efd[2]
  
  # Latest File Date & Name
  lfd <- unlist(file_date_name(df,max))
  lf_name <- lfd[1]
  lf_date<-lfd[2]
  
  # Generating summary of s3 bucket metadata
  s3_summary <- list(total_objects,total_space,avg_file_size,unique_file_extension,msg_unique_extensions,mfe,lfs_size,lfs_name,sfs_size,sfs_name,ef_date,ef_name,lf_date,lf_name)
  s3_summary<-as.data.frame(unlist(s3_summary))
  rownames(s3_summary)<- c("total_objects","total_space","avg_file_size","unique_file_extension","unique_extensions_name","mfe","lfs_size","lfs_name","sfs_size","sfs_name","ef_date","ef_name","lf_date","lf_name")
  s3_summary<-data.frame(t(s3_summary))
  rownames(s3_summary) <- NULL
  
  # converting epoch to datetime
  s3_summary$ef_date <- convert_epoch_to_date_time(s3_summary$ef_date)
  s3_summary$lf_date <- convert_epoch_to_date_time(s3_summary$lf_date)
  
  return(s3_summary)
}