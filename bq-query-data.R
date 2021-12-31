
# Setup -------------------------------------------------------------------

library(tidyverse)
library(bigrquery)
bq_auth()

## Replace with the correct `project ID`
project_id <- 'bq_project_id'

# Queries -----------------------------------------------------------------

sql_user_trend <- "
select
   event_date,
   count(distinct(user_pseudo_id)) as users
from
   `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
where
   _TABLE_SUFFIX between '20201101' and '20211231'
group by event_date
order by event_date;   
"

sql_events_trend <- "
select 
   event_date,
   event_name,
   COUNT(*) as event_count
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
where 
   event_name in ('page_view', 'session_start', 'purchase')
   and _TABLE_SUFFIX between '20201101' and '20211231'
group by 1, 2
order by event_date;   
"

# Data export -------------------------------------------------------------

## User trend export
gms_users_export <- bq_project_query(project_id, sql_user_trend) %>% 
  bq_table_download() 

## Event trend export
gms_events_export <- bq_project_query(project_id, sql_events_trend) %>% 
  bq_table_download()

# Tidy exported data ------------------------------------------------------

gms_events_tidy <- gms_events_export %>% 
   pivot_wider(names_from = event_name, values_from = event_count)

gms_data_tidy <- gms_users_export %>% 
   left_join(gms_events_tidy, by = "event_date")

# Write data locally ------------------------------------------------------

write_csv(gms_data_tidy, "ga4_data.csv")
