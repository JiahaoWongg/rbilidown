#' @title print_info 
#' @author Jiahao Wang 
#' @export  
 
print_info <- function(info){ 
    cat("\n***************************\n") 
    cat(info, "\n") 
    cat("***************************\n\n") 
} 
 
#' @title contact_author 
#' @author Jiahao Wang 
#' @export  
contact_author <- function(){ 
    print_info(paste0("If you have any question, please send mail to jhaowong1998@sina.com\n", 
                      "Or follow wechat official account 【bioinforbaidu】\n\n", 
                      "如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com\n", 
                      "或关注微信公众号【bioinforbaidu】或【生信摆渡】后台回复")) 
} 
 
#' @title check_utils 
#' @author Jiahao Wang 
#' @export  
check_utils <- function(){ 
    you_get = paste0(.libPaths(), "/rbilidown/utils/you-get.exe") 
    ffmpeg = paste0(.libPaths(), "/rbilidown/utils/ffmpeg.exe") 
    if(!file.exists(you_get) & !file.exists(ffmpeg)){ 
        check_you_get = system("you-get --version") 
        check_ffmpeg = system("ffmpeg --version") 
        if(!check_you_get & !check_ffmpeg){ 
        stop("Required utils not found!\nPlease download from")             
        } 
    } 
} 
 
#' @title countSpan 
#' @author Jiahao Wang 
#' @export  
countSpan <- function(start, end){ 
    extractClock <- function(time){ 
        clock = strsplit(time, ":")[[1]] 
        hor = as.integer(clock[1]) 
        min = as.integer(clock[2]) 
        sec = as.integer(clock[3]) 
        return(list = c(hor, min, sec)) 
    } 
 
    timeM = sapply(c(start, end), extractClock) 
    hor_ST = timeM[1, 1] 
    min_ST = timeM[2, 1] 
    sec_ST = timeM[3, 1] 
    hor_ED = timeM[1, 2] 
    min_ED = timeM[2, 2] 
    sec_ED = timeM[3, 2] 
     
    if(sec_ED >= sec_ST){ 
        sec_span = sec_ED - sec_ST 
        if(min_ED >= min_ST){ 
            min_span = min_ED - min_ST 
            hor_span = hor_ED - hor_ST 
        } else{ 
            min_span = min_ED + 60 - min_ST 
            hor_span = (hor_ED - 1) - hor_ST 
        } 
 
    } else{ 
        sec_span = sec_ED + 60 - sec_ST 
        if((min_ED - 1) >= min_ST){ 
            min_span = (min_ED - 1) - min_ST 
            hor_span = hor_ED - hor_ST 
        } else{ 
            min_span = (min_ED - 1) + 60 - min_ST 
            hor_span = (hor_ED - 1) - hor_ST 
        } 
    } 
 
    checkTen <-function(n){ 
        if(n < 10){ 
            n = paste0("0", n) 
        } else{ 
            n = as.character(n) 
        } 
        return(n) 
    } 
 
    hor_span = checkTen(hor_span) 
    min_span = checkTen(min_span) 
    sec_span = checkTen(sec_span) 
    span = paste0(hor_span, ":", min_span, ":", sec_span) 
    return(span) 
} 
 
get_best_quality <- function(url, cookie = NULL){ 
 
    check_utils() 
 
    print_info(paste0("Findding best quality format ...\n", 
                     "Getting video information, this may take 1 ~ 2 minutes.\nMaybe more, just wait.")) 
    you_get = paste0(.libPaths(), "/rbilidown/utils/you-get.exe") 
    if(!file.exists(you_get)){ 
        you_get = "you_get" 
    } 
 
    info = system(paste(you_get, "-i", url), intern = TRUE) 
    idx_quality = grep("quality", info)[-1] 
    qualitys = gsub("[PK]", "", sapply(strsplit(info[idx_quality], " "), function(x) tail(x, 1))) 
    qualitys = as.numeric(qualitys) 
    qualitys[qualitys < 10] = qualitys[qualitys < 10] * 1000 
    idx_quality_max = idx_quality[order(qualitys, decreasing = TRUE)[1]] 
    idx_cmd_quality_max = idx_quality_max + 2 
    cmd_quality_max = strsplit(info[idx_cmd_quality_max], " ")[[1]][8] 
    quality_max_num = qualitys[order(as.numeric(qualitys), decreasing = TRUE)[1]] 
    if(quality_max_num > 3000){ 
        quality_max = paste0(quality_max_num / 1000, "K") 
    } else { 
        quality_max = paste0(quality_max_num, "P") 
    } 
    print_info(paste("Found best quality format:", quality_max))             
    return(cmd_quality_max) 
} 
 
