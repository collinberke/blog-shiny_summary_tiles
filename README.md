# Shiny Summary Metric Tiles Example

This repository contains code from a [blog post](https://www.collinberke.com/post/shiny-series-metric-summary-tiles/) overviewing the creation of [Shiny](https://shiny.rstudio.com/) summary tiles. A running example of the Shiny app utilizing summary metric tiles can be found [here](https://collin-berke.shinyapps.io/blog-shiny_summary_tiles/). 

It also contains some example code utilizing the `R` [`bigrquery`](https://bigrquery.r-dbi.org/) package to export Google Analytics 4 data for the [Google Merchandise Store](https://shop.googlemerchandisestore.com/) from [BigQuery](https://cloud.google.com/bigquery). 

# Data 

The data was provided through [Google’s Public Datasets](https://cloud.google.com/bigquery/public-data) initiative, and it can be accessed and used by anyone (as long as you have a Google account). This data represents web site activity, specifically site events from 2020-11-01 to 2021-12-31. This is an obsfucated sample dataset, thus no valid conclusions about the Google Merchandise store and its usage should be made from this data or application. This example code is meant to highlight Shiny concepts and is not intended to be a valid analysis of website activity. More about the data can be found [here](https://support.google.com/analytics/answer/10937659#zippy=%2Cin-this-article).

# Bugs, issues, or improvements

Please file an [issue](https://github.com/collinberke/blog-shiny_summary_tiles/issues) if you find any bugs. Suggestions for improvements/optimizations through [pull requests](https://github.com/collinberke/blog-shiny_summary_tiles/issues) are always welcome and apprecitated. 
