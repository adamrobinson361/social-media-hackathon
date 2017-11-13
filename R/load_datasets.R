job_titles <- read_csv("Data/jt_exploded.csv")

provided_data <- read_csv("Data/cdf-tw.csv") %>%
  mutate(status_id = id)



