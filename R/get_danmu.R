#' Get danmaku of video. 
#' Get danmaku of video. 
#' @title get_danmu  
#' @import XML 
#' @param url Video URL, required, remember with double quotation marks.  
#' @param out_dir Output, directory, required.  
#' @author Jiahao Wang 
#' @return Nothing, infornation will be printed to screen. 
#' @export  
get_danmu <- function(url, out_dir){ 
 
    contact_author() 
    check_utils() 
 
    print_info(paste0("Before get danmaku, we need download video first.\n", 
                      "Getting video information, this may take 1 ~ 2 minutes.\n", 
                      "Maybe more, just wait.")) 
 
    out_tmp = paste0(out_dir, "/get_video_tmp_", uid()) 
    dir.create(out_tmp) 
 
    you_get = paste0(.libPaths(), "/rbilidown/utils/you-get") 
    invisible(system(paste(you_get, "-o", out_tmp, url))) 
 
    files_flv = list.files(out_tmp, ".flv$", full.names = TRUE) 
    formate_convert("flv", "mp4", files_flv) 
 
    xml = list.files(out_tmp, ".xml", full.names = TRUE) 
    text = XML::xmlToDataFrame(xml)$text[-c(1:7)] 
    mp4_files = list.files(out_tmp, ".mp4$", full.names = TRUE) 
    file_out = paste0(dirname(mp4_files), "/", gsub(".mp4", "", basename(mp4_files)), "_danmu.txt") 
    write.table(text, file_out, row.names = FALSE, col.names = FALSE, quote = FALSE, fileEncoding = "UTF-8") 
    unlink(xml) 
 
    file.copy(file_out, out_dir)        
    unlink(out_tmp, recursive = TRUE) 
    print_info(paste0("Finished!\nExacute 'shell.exec(\"", out_dir, "\")' to open out directory.")) 
} 
