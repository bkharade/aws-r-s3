#* check if the API is running
#* @serializer unboxedJSON
#* @get /
function(req,res) {
    data <- "API testing"
    log_info(paste0("calling the heath function::",data))
    return(list(message = paste("R service running.. ", Sys.time())))
}