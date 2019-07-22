# Function frequency_table() generates a frequency table for the s3 bucket

frequency_table <- function(df,bin_size){
  
  # Total Objects
  total_obj <- nrow(df)
  
  # Function to create a ceil generator (ex: ceil50 will generate range 0-50,50-100,... )
  ceilGenerator <- function(num) 
  function(x) num * ceiling(x / num) 
  
  ceil_gen<- ceilGenerator(bin_size) 
  df$size <- as.numeric(df$size)
  
  to <-  ceil_gen(max(df$size))

  # Creating Bins and frequency table
  br = seq(0, to ,by= bin_size)
  ranges = paste(head(br,-1), br[-1], sep=" - ")
  freq   = hist(df$size, breaks=br, include.lowest=TRUE, plot=FALSE)
  freq_table <-data.frame(range = ranges, frequency = freq$counts)
  
  return(freq_table)
}
