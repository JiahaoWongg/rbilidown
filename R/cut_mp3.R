#' Cut mp3. 
#' Cut mp3 with specific start and end time point. 
#' @title cut_mp3  
#' @param input_mp3 mp3 file path.  
#' @param start cut start time point, format: HH:MM:SS(时分秒).  
#' @param end cut end time point, format: HH:MM:SS(时分秒).  
#' @param out_mp3 output mp3 file path, default source file name plus time point.  
#' @author Jiahao Wang  
#' @return Nothing.  
#' @export 
cut_mp3 <- function(input_mp3, start, end, out_mp3 = NULL){ 
    contact_author() 
    check_utils() 
    if(is.null(out_mp3)){ 
        out_mp3 = paste0(gsub(".mp3", "", input_mp3), "_from_", gsub(":", "", start), "_to_", gsub(":", "", end), ".mp3") 
    } 
 
    if(file.exists(out_mp3)){ 
        print_info("Cutting already finished!\n") 
    } else { 
        print_info(paste0("Cutting mp3, file will save to", "'", dirname(out_mp3), "'")) 
        ffmpeg = paste0(.libPaths(), "/rbilidown/utils/ffmpeg") 
        span = countSpan(start, end) 
        cmd = paste(ffmpeg, "-i", input_mp3, "-vn -acodec copy") 
        cmd = paste(cmd, "-ss", start) 
        cmd = paste(cmd, "-t", span, out_mp3) 
        invisible(system(cmd, ignore.stderr = TRUE))         
    } 
} 
