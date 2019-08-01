# [s3 Analyzer](https://rajkstats.shinyapps.io/s3-analyzer/) - Web app to analyze your s3 bucket 

### Quick Overview
This is a mini project I started to easily analyze s3 bucket with  R's flexdashboard package.

#### Why s3 Analyzer ? 

* See how files under your s3 bucket/path are distributed (in terms of size)
* [AWS CLI](https://aws.amazon.com/cli/) summarise provides file sizes which are not uniform in size
* s3 Analyzer converts all different file sizes (EiB,PiB,TiB,GiB,KiB,Bytes) to a uniform unit i.e **MiB** 
* Renders **total files** under s3 bucket/path  
* Creates a **frequency table** for all files and shows **% files** in each s3 bucket 
* Renders a interactive bar plot to **visually** show how your files are distributed

####  How to use App ? 

* s3 Analyzer loads a default processed public s3 dataset [GEOS-Chem on cloud](https://cloud-gc.readthedocs.io/en/stable/chapter02_beginner-tutorial/use-s3.html) (Total Files: 11,948,
                                                                                                                                                                    Total Size: 4.2 TiB)
* You can upload your processed file (**max file size** = **50 MiB**) using **AWS CLI** on your s3 bucket/path
* Choose bin size - (50 MiB or 100 MiB)
* Click on Apply button for action 


#### Processed files from s3 bucket

* Here are few processed datasets available at analyzer [github repo](https://github.com/rajkstats/s3_Analyzer/blob/master/00_Data/) to try the web app taken from: 
  * [common-crawl](https://registry.opendata.aws/commoncrawl/)
  * [gdelt](https://registry.opendata.aws/gdelt/)       

* You can also create processed files using public s3 buckets at [AWS Open Data](https://registry.opendata.aws/)


#### How to get processed file from **AWS CLI** ?

* Following command using the ls to list all files and
   --human-readable displays file size in Bytes/MiB/KiB/GiB/TiB/PiB/EiB 
   --summarize displays the total number of objects and total size at the end of the result 
   and copies the output to s3_analysis.csv file 

   <pre>
     aws s3 ls --recursive --human-readable --summarize  s3://nasanex/NEX-GDDP/BCSD/rcp45/ > s3_analysis_nasanex.csv
   </pre>      

     
* Upload the processed file **s3_analysis_nasanex.csv** to **s3 Analyzer**     

### Tools

[R v3.5.1](https://www.r-project.org/) and [RStudio v1.2.1335](https://www.rstudio.com/) were used to build this tool.

The packages used were:

* [flexdashboard](https://rmarkdown.rstudio.com/flexdashboard/) to create a frame for the content
* [DT](https://rstudio.github.io/DT/) for the interactive table
* [data.table]()  for data manipulation
* [plotly](https://github.com/ropensci/plotly) for interactive visualization
* [tools](http://web.mit.edu/~r/current/arch/amd64_linux26/lib/R/library/tools/html/tools-package.html) for extension of a file path
* [gdata](https://cran.r-project.org/web/packages/gdata/index.html) for Human Readable File sizes
* [stringr](https://www.rdocumentation.org/packages/stringr/versions/1.4.0)  for string manipulation
* [shinyWidgets](https://github.com/dreamRs/shinyWidgets) for providing some custom widgets to pimp your shiny apps
* [shinyjs](https://github.com/daattali/shinyjs) for improving the user experience of your Shiny apps
* [Ion icons](https://ionicons.com/) and [Font Awesome](https://fontawesome.com/) for icons


#### Interactive Plot

You can:
  
* click the camera button to download bar plot as png
* zoom with the '+' and '-' buttons (top-right) or with your mouse's scroll wheel
* click the button showing a broken square (top-left under the zoom options) to select points on the plot using a window that's 
draggable (click and hold the grid icon in the upper left) and resizeable (click and drag the white boxes in each corner)


#### Interactive Table

You can:

* sort the columns (ascending and descending) by clicking on the column header
* scroll the table vertcially to see all elements 
* click 'CSV' or 'Excel' to download the  data to a .csv file or a .xlsx


#### Credits

* Public s3 dataset [GEOS-Chem on cloud](https://cloud-gc.readthedocs.io/en/stable/chapter02_beginner-tutorial/use-s3.html) (Total Files: 11,948
                      Total Size: 4.2 TiB)

* Public s3 datasets [AWS opendata](https://registry.opendata.aws/)

* Inspired from this [Blogpost](https://whitfin.io/analyzing-your-buckets-with-s3-meta/)

* Inspired from [Sales Dashboard By Joon](https://joon.shinyapps.io/veh_parts_sales_dash/)

    
### Contact

For any feedback, comments or questions, please write to me at raj.k.stats@gmail.com.
