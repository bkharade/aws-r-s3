HOST <- Sys.getenv("HOST","0.0.0.0")

PORT <- strtoi(Sys.getenv("PORT",8080))

WORKERS <-strtoi(Sys.getenv("WORKERS",3))