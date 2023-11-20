#' Get information of video. 
#' Get information of video. 
#' @title get_info  
#' @param url Video URL, remember with double quotation marks.  
#' @author Jiahao Wang 
#' @return Nothing, infornation will be printed to screen. 
#' @export  
get_info <- function(url){ 
    contact_author() 
    check_utils() 
    print_info("Getting video information, this may take 1 ~ 2 minutes.\nMaybe more, just wait.") 
    you_get = paste0(.libPaths(), "/rbilidown/utils/you-get") 
    system(paste(you_get, "-i", url)) 
} 
