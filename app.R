library(plumber)
library(haven)
library(paws)
library(jsonlite)
library(dplyr)


options(warn = -1)

# load helpers
source("./helper/env.R")
source("./helper/logging.R")
source("./helper/parallel.R")
source("./helper/error.R")

app <- pr()

options_plumber(trailingSlash = TRUE)

app %>%
  pr_set_error(error_handler) %>%
  pr_hooks(list(preroute = pre_route_logging, postroute = post_route_logging))

r_routes_file_names = list.files(path = './routes/demo', full.names=TRUE, recursive=TRUE)
for (file_name in r_routes_file_names) {
    routeName = substring(file_name, 10, nchar(file_name) - 2)
    app %>%
     pr_mount(routeName, pr(file_name) %>% pr_set_error(error_handler))
}

app %>%
  pr_set_api_spec(function(spec){
    spec$info <- list( title = "Demo API" , description = "API layer for testing")
    spec$tags <- list( list(name= "health" ,description = "health Check"))
    spec
  })

  app %>%
   pr_run(host = HOST , port = PORT)