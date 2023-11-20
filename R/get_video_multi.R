#' Download video using you-get. 
#' Download multiple videos with specific config file. 
#' @title get_video_multi  
#' @param config_input Input config file, not neccessary when build config using parameter 'prepare'.  
#' @param out_dir Output directory, required.  
#' @param prepare Automaticaly create and open a new config file.  
#' @param prepare_name Name using for creat config file.  
#' @author Jiahao Wang 
#' After run get_video_multi(out_dir, prepare = TRUE), the config file with be created and open. 
#' Values in column 'mp3 remove.mp4 danmu' should be assign with 1 if you want set to TRUE 
#' And not assign angthing if you want set to FALSE and NULL 
#' @return Nothing. 
#' @export  
get_video_multi <- function(config_input = NULL, out_dir = NULL, prepare = FALSE, prepare_name = "get_video_multi"){ 
    if(is.null(out_dir)){ 
        out_dir = getwd() 
        print_info(paste0("'out_dir' not specific! Use current directory ", getwd(), " as out.")) 
    } 
 
    if(prepare){ 
        config_input = paste0(dirname(out_dir), "/", prepare_name, "_config.csv") 
        if(file.exists(config_input)){ 
            print_info(paste0("Default config file already exists: ", config_input, "\n",  
                              "Please remove/rename it or specific a new config file!")) 
            stop() 
        } else { 
            cat("url,out_name,mp3,start,end,remove.mp4,danmu\n", file = config_input)             
            print_info(paste0("Config file build success: ", config_input, "\n",  
                              "Please exit it.")) 
            shell.exec(config_input) 
        } 
    } else { 
         
        if(is.null(config_input)){ 
            config_input = paste0(dirname(out_dir), "/", prepare_name, "_config.csv")         
        } 
 
        config_table = read.table(config_input, sep = ",", fileEncoding = "GBK", header = T) 
        config_table[is.na(config_table)] = 0 
        config_table[config_table == ""] = 0 
        print_info(paste0(nrow(config_table), " video to download!")) 
 
        for(i in 1:nrow(config_table)){ 
            print_info(paste0("Downloadding multi videos ", i, "/", nrow(config_table), " ...")) 
 
            url = config_table[i, 1] 
            out_dir = out_dir 
 
            if(config_table[i, 2] != 0){ 
                out_name = config_table[i, 2] 
            } else { 
                out_name = NULL 
            } 
 
            mp3 = as.logical(config_table[i, 3]) 
 
            if(config_table[i, 4] != 0){ 
                start = config_table[i, 4] 
            } else { 
                start = NULL 
            } 
 
            if(config_table[i, 5] != 0){ 
                end = config_table[i, 5] 
            } else { 
                end = NULL 
            } 
 
            if(config_table[i, 6] != 0){ 
                remove.mp4 = TRUE 
            } else { 
                remove.mp4 = FALSE 
            } 
 
            danmu = as.logical(config_table[i, 7]) 
            cat("url:", url, "\n") 
            cat("out_dir:", out_dir, "\n") 
            cat("out_name:", out_name, "\n") 
            cat("mp3:", mp3, "\n") 
            cat("start:", start, "\n") 
            cat("end:", end, "\n") 
            cat("remove.mp4:", remove.mp4, "\n") 
            cat("danmu:", danmu, "\n") 
 
            get_video(url, out_dir, out_name = out_name, mp3 = mp3, start = start, end = end, 
                      remove.mp4 = remove.mp4, danmu = danmu) 
        } 
        print_info("All video download succeed!") 
    } 
 
} 
