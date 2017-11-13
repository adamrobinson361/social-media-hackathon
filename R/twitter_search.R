library("rtweet")
#https://github.com/mkearney/rtweet

## name assigned to created app
appname <- "adamrobinson361_r_mining"
## api key (example below is not a real key)
key <- "3Z0j2BSc8E8dwjvfy9YFgZtfz"
## api secret (example below is not a real key)
secret <- "hCdvlvlRylE8RoEoNU6WCIlHuVnZT6W91Q4C4bG6I3C2MDcYzI"

twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret)

rm(list = c("access_secret", "access_token","appname","consumer_key", "consumer_secret","key","secret","token"))

