#' Formate Convert for Video. 
#' Only support convert flv to mp4 or mp4 to mp3. 
#' @title formate_convert  
#' @param from Source format, flv|mp4.  
#' @param to Target format mp4|mp3.  
#' @param files_input Input video path, one or more.  
#' @author Jiahao Wang  
#' @return Nothing.  
#' @export 
formate_convert <- function(from, to, files_input, out_name = NULL){ 
 
    contact_author() 
    check_utils() 
    ffmpeg = paste0(.libPaths(), "/rbilidown/utils/ffmpeg") 
    new_names = paste0(dirname(files_input), "/", gsub(" ", "_", basename(files_input))) 
    file.rename(files_input, new_names) 
    if(from == "flv" & to == "mp4"){ 
        for(file in new_names){ 
            file_out = gsub(".flv", ".mp4", file) 
            if(file != file_out){ 
                print_info(paste0("Converting flv to mp4, file will save to '", dirname(file_out))) 
                system(paste0(ffmpeg, " -i ", file, " ", file_out), ignore.stderr = TRUE) 
                file.rename(file_out, paste0(dirname(file_out), "/", gsub("_", " ", basename(file_out)))) 
            } 
        } 
    } else if(from == "mp4" & to == "mp3"){ 
        for(file in new_names){ 
            file_out = gsub(".mp4", ".mp3", file) 
            print_info(paste0("Converting mp4 to mp3, file will save to '", dirname(file_out))) 
            system(paste0(ffmpeg, " -i ", file, " ", file_out), ignore.stderr = TRUE) 
            file.rename(file_out, paste0(dirname(file_out), "/", gsub("_", " ", basename(file_out)))) 
        } 
    } else { 
        stop("Only support convert flv to mp4 or mp4 to mp3\n") 
    } 
 
    file.rename(new_names, files_input) 
 
    if(!is.null(out_name)){ 
        if(length(from) > 1){ 
            print_info("Warning: Multi input files, specific out_name will be ignored!") 
        } else { 
            file_new = paste0(dirname(file_out), "/", out_name, ".", to) 
            file.rename(file_out, file_new) 
        } 
    } 
 
} 
