get_storage_client <- function () {
    s3 <- paws::s3(config = list(region='us-east-2'))
    return(s3)
}

download_s3_file <- function(s3, reqData) {
    
    s3_download <- s3$get_object( Bucket = reqData$bucket_name, Key = reqData$file_name)

    download_path <- '/mnt/s3'

    downloaded_file_name <- paste(download_path,reqData$file_name,seq="/")
    log_info(paste0("writing file with filename::" ,downloaded_file_name))
    tryCatch ({
        writeBin(s3_download$Body, con = downloaded_file_name)
    }, error = function (cond) {
        message(paste("Cannot write file::",downloaded_file_name))
        message("here's the original message:")
        message(conditionMessage(cond))
    },finally = {
        log_info(paste0("returning file with fileName::",downloaded_file_name))
        return (downloaded_file_name)
    })
}

#* @tag s3objects
#* @serializer unboxedJSON
#* @param file_name:str
#* @post /data/preview
function(req,res) 
{
    log_info("/data/preview called")
    s3 <- get_storage_client()
    s3_file <- download_s3_file(s3,req$body)
    log_info(paste0("in preview calling the preview for file with filename::",s3_file))
    dataDM <- haven::read.csv(s3_file)

    return(head(dataDM, 100))
}

