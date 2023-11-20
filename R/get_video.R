#' Download video using you-get. 
#' Support Youtube/Bilibili and other non-VIP video. 
#' @title get_video  
#' @import ids 
#' @import XML 
#' @param url Video URL, remember with double quotation marks.  
#' @param out_dir Output directory, default current directory.  
#' @param all_list Whether download videos in this vidio list(下载所有分P视频).  
#' @param out_name Rename output file, DO NOT contain suffix, DO NOT use it when using 'all_list'.  
#' @param mp3 Whether convert mp4 to mp3.  
#' @param start Start time point of mp3 cutting, format: HH:MM:SS(时分秒).  
#' @param end End time point of mp3 cutting, format: HH:MM:SS(时分秒).  
#' @param remove.mp4 Whether remove mp4 file. 
#' @param danmu Whether save danmaku. 
#' @author Jiahao Wang 
#' @return Nothing. 
#' @export  
# To do: 
#   - formate_convert处理多个文件时需要回车才能执行下一个文件: flush.console() 
#   - 新增get_best_quality函数, 返回视频最高画质的下载格式, 仍然尝试cookie, 后续下载时也尝试cookie 
#       - 不同网站的cookie需分别获取, 返回的视频信息的格式也不同, 需要针对性处理, 目前只测试B站和Youtube 
get_video <- function(url = NULL, out_dir = NULL, format = NULL, all_list = FALSE, out_name = NULL, mp3 = FALSE,  
                      start = NULL, end = NULL, remove.mp4 = FALSE, danmu = FALSE){ 
 
    contact_author() 
    check_utils() 
 
    if(is.null(url)){ 
        stop(paste0("'url' to download is required!")) 
    } 
 
    if(is.null(out_dir)){ 
        out_dir = getwd() 
        print_info(paste0("'out_dir' not specific! Use current directory ", getwd(), " as out.")) 
    } else { 
        if(!dir.exists(out_dir)){ 
            print_info(paste0("Specific 'out_dir' not exists, creat it!")) 
            dir.create(out_dir, recursive = TRUE) 
        } 
    }         
 
    you_get = paste0(.libPaths(), "/rbilidown/utils/you-get.exe") 
    if(!file.exists(you_get)){ 
        you_get = "you_get" 
    } 
 
    if(grepl("^BV", url)){ 
        url = paste0("https://www.bilibili.com/video/", url) 
    } 
 
    if(!is.null(format)){ 
        cmd_quality_max = format 
    } else { 
        if(!mp3){ 
            cmd_quality_max = get_best_quality(url)             
        } else { 
            cmd_quality_max = "" 
        } 
    } 
 
    out_tmp = paste0(out_dir, "/get_video_tmp_", ids::uuid())  
    dir.create(out_tmp)  
 
    print_info("Downloadding ...\nGetting video information, this may take 1 ~ 2 minutes.\nMaybe more, just wait.")  
    if(all_list){ 
        system(paste(you_get, cmd_quality_max, "-l -o", out_tmp, url)) 
    } else {     
        system(paste(you_get, cmd_quality_max, "-o", out_tmp, url)) 
    } 
 
    files = list.files(out_tmp, full.names = TRUE) 
    files_new = gsub(" ", "_", files) 
    file.rename(files, files_new) 
 
    if(!is.null(out_name)){ 
        if(all_list){ 
            print_info("Warning: video for list can not be renamed, specific out_name will be ignored!") 
        } else { 
            print_info(paste("File rename to", out_name)) 
            file_prefix = gsub(".cmt.xml", "", list.files(out_tmp, ".xml$", full.names = TRUE)) 
            files_old = list.files(out_tmp, full.names = TRUE) 
            files_new = gsub(file_prefix, paste0(dirname(file_prefix), "/", out_name), files_old) 
            file.rename(files_old, files_new) 
        } 
    } 
 
    files_flv = list.files(out_tmp, ".flv$", full.names = TRUE) 
    if(length(files_flv) != 0){ 
        formate_convert("flv", "mp4", files_flv) 
    } 
 
    if(mp3){ 
        mp4_files = list.files(out_tmp, ".mp4$", full.names = TRUE) 
        formate_convert("mp4", "mp3", mp4_files) 
    } 
 
 
    if(!is.null(start)){ 
        mp3_file = list.files(out_tmp, ".mp3$", full.names = TRUE) 
        if(length(mp3_file) > 1){ 
            print_info("Warning: Multi mp3 found, cut_mp3 will not be executed!") 
        } else { 
            if(is.null(out_name)){ 
                cut_mp3(mp3_file, start, end)         
                unlink(mp3_file) 
            } else{ 
                mp3_rename = paste0(gsub(".mp3", "", mp3_file), "_cut_before.mp3") 
                file.rename(mp3_file, mp3_rename) 
                cut_mp3(mp3_rename, start, end, out_mp3 = mp3_file)         
                unlink(mp3_rename) 
            } 
        } 
    } 
 
    xml = list.files(out_tmp, ".xml", full.names = TRUE) 
    if(danmu){ 
        cat("Getting danmaku ...\n") 
        text = XML::xmlToDataFrame(xml)$text[-c(1:7)] 
        mp4_files = list.files(out_tmp, ".mp4$", full.names = TRUE) 
        file_out = paste0(dirname(mp4_files), "/", gsub(".mp4", "", basename(mp4_files)), "_danmu.txt") 
        write.table(text, file_out, row.names = FALSE, col.names = FALSE, quote = FALSE, fileEncoding = "UTF-8") 
    } 
    unlink(xml)         
 
    if(remove.mp4){ 
        print_info("mp4 file will be deleted!") 
        mp4_files = list.files(out_tmp, ".mp4$", full.names = TRUE) 
        unlink(mp4_files) 
    } 
 
    files_flv = list.files(out_tmp, ".flv$", full.names = TRUE) 
    unlink(files_flv) 
 
    # save 
    files_save = list.files(out_tmp, full.names = TRUE) 
    invisible(sapply(1:length(files_save), function(i) file.copy(files_save[i], out_dir))) 
    unlink(out_tmp, recursive = TRUE) 
    print_info(paste0("Finished!\nExacute 'shell.exec(\"", out_dir, "\")' to open out directory.")) 
} 
