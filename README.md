# rbilidown - B站视频下载、转音频工具

> 版本: 1.0.0
>
> 作者: Jiahao Wang
>
> 公众号: 生信摆渡
>
> 联系: jhaowong1998@sina.com

`rbilidown` 是基于工具 [you-get](https://you-get.org/) 和 [ffmpeg](https://ffmpeg.org/)使用R语言所编写的一个工具包，用于B站非会员视频的下载、视频转音频、音频分割。

仅需要提供BV号或BV列表以及想要的参数即可快速完成。

## 安装

工欲善其事必先利其器。

### 1. R

由于该工具是R语言编写的，因此R语言编译器是必须要安装的，访问[R 安装包]([The Comprehensive R Archive Network (tsinghua.edu.cn)](https://mirrors.tuna.tsinghua.edu.cn/CRAN/)) 点击`Download R-4.3.1 for Windows`即可，记住安装的位置，比如`D:/path_to_R`。

安装后 将`D:/path_to_R/bin/x64` 添加至[环境变量](https://www.jianshu.com/p/1717c6cad9e7)，即可使用R了。

按`win + R`输入`cmd`回车，弹出命令行界面，输入`R --version`得到版本信息说明安装成功。

### 2. rbilidown

接下来就是安装我们的工具包了。同样在命令行界面，输入R进入R的交互界面，输出以下内容进行安装：

```R
install.packages("remotes")
remotes::install_github("https://github.com/JiahaoWongg/rbilidown")
```

继续输入

```R
library(rbilidown)
```

得到以下内容，说明安装成功:

```R
Loading required package: ids
Loading required package: XML

Warning message:
package 'XML' was built under R version 4.2.3
```

### 3. you-get 和 ffmpeg

you_get可以[使用python安装](https://you-get.org/#installation)，ffmpeg在[这里安装](https://www.ffmpeg.org/download.html)。

当然，这里我提供了打包好的两个软件的可执行文件，可惜R官方出于安全考虑不允许R包里携带可执行文件，所以只能手动另外下载了。

公众号【生信摆渡】回复【rbilidown】即可获取压缩包。

解压之后将解压的目录同样添加至环境变量，我们就可以用了。

检查一下，在cmd界面，输入`you-get --version` 和 `ffmpeg -version`看到版本信息即安装成功。

## 使用方法

每次使用时需先进入R交互界面: 按`win + R`输入`R`回车即.

然后加载我们的工具包，就能使用里面的工具了: `library(rbilidown)`.

使用 `ls("package:rbilidown")` 查看包内有哪些可用函数.

使用 `?function` 即问号加函数名即可查看每个每个函数的使用方法.

### 1. get_info

获取视频信息，可用于获取指定格式视频的下载命令。参数:

- url: 视频URL

获取视频信息总是要等待几十甚至一两分钟，在下载之前也要先获取视频信息，因此每次下载时都要先等待一小会~

### 2. formate_convert

格式转换，用于flv转mp4和mp4转mp3。参数:

- from: 源格式, flv 或 mp4
- to: 目标格式, mp4或mp3
- files_input: 输入文件路径
- out_name: 输出文件名，可选

### 3. cut_mp3

mp3音频切割，用于得到指定起始和结尾位置的音频。参数:

- input_mp3: 输入文件路径
- start: 起始时间点，格式: HH:MM:SS(时分秒)

- end，结束时间点，格式: HH:MM:SS(时分秒)

- out_mp3: 输出文件名，可选

### 4. get_danmu

获取视频弹幕内容。参数:

- url: 视频URL
- out_dir: 弹幕输出文件夹

### 5. get_video

最主要的一个函数，用于下载视频，此外还有视频转音频、音频切割、获取弹幕的功能。参数:

- url: 视频链接
- out_dir: 结果输出目录，可选，默认当前目录
- all_list: 是否下载所有分P视频
- out_name: 输出文件名
- mp3: 是否转成音频
- start: 音频切割起始时间点，格式: HH:MM:SS(时分秒)
- end: 音频切割结束时间点，格式: HH:MM:SS(时分秒)
- remove.mp4: 是否删除视频
- danmu: 是否保存弹幕内容

### 6. get_video_multi

基于`get_video`的升级版，可以根据提供的视频信息列表，批量自动下载处理视频。参数：

- config_input: 输入批量视频信息文件, 也是由本函数创建的，往下看
- out_dir: 结果输出目录
- prepare: 是否生成一个空的视频信息列表文件
- prepare_name: 指定列表文件的文件名，可选，默认生成在当前目录下的`get_video_multi`

## 使用示例

### 1. 下载单个视频

由于B站的用户视频都是以BV开头的，很容易区分，所以只需要提供BV号即可。

#### 快速下载

```R
get_video("BV1dt411a7FX")
```

屏幕会依次输出以下信息：

```
***************************
If you have any question, please send mail to jhaowong1998@sina.com
Or follow wechat official account 'bioinforbaidu'

如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com
或关注微信公众号'bioinforbaidu'或'生信摆渡'后台回复
***************************


***************************
'out_dir' not specific! Use current directory C:/Users/jhaow as out.
***************************


***************************
Findding best quality format ...
Getting video information, this may take 1 ~ 2 minutes.
Maybe more, just wait.
***************************


***************************
Found best quality format: 480P
***************************


***************************
Downloadding ...
Getting video information, this may take 1 ~ 2 minutes.
Maybe more, just wait.
***************************

site:                Bilibili
title:               周杰伦秘密花园扒带伴奏！既然原版的不够清晰，那就自己做一个吧！
stream:
    - format:        dash-flv480
      container:     mp4
      quality:       清晰 480P
      size:          16.2 MiB (16963444 bytes)
    # download-with: you-get --format=dash-flv480 [URL]

Downloading 周杰伦秘密花园扒带伴奏！既然原版的不够清晰，那就自己做一个吧！.mp4 ...
 100% ( 16.2/ 16.2MB) ├████████████████████████████████████████┤[2/2]   12 MB/s
Merging video parts... Merged into 周杰伦秘密花园扒带伴奏！既然原版的不够清晰，那就自己做一个吧！.mp4

Downloading 周杰伦秘密花园扒带伴奏！既然原版的不够清晰，那就自己做一个吧！.cmt.xml ...


***************************
If you have any question, please send mail to jhaowong1998@sina.com
Or follow wechat official account 'bioinforbaidu'

如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com
或关注微信公众号'bioinforbaidu'或'生信摆渡'后台回复
***************************


***************************
Finished!
Exacute 'shell.exec("C:/Users/jhaow")' to open out directory.
***************************
```

按照指示执行`shell.exec("C:/Users/jhaow")`后即可自动打开输出目录。可以看到已经下载好啦

![image-20231030174910837](https://raw.githubusercontent.com/JiahaoWongg/picBed/main/202311202324178.png)

#### 指定参数

我们想要的是：将视频转成音频，重命名、删除下载的mp4文件，保存弹幕，保存特定时间范围的音频：

```R
get_video("BV1dt411a7FX", "video", out_name = "周杰伦-秘密花园(扒带)", mp3 = TRUE, remove.mp4 = TRUE, danmu = TRUE, start = "00:00:30", end = "00:01:30")
```

屏幕会依次输出以下信息：

```
***************************
If you have any question, please send mail to jhaowong1998@sina.com
Or follow wechat official account 'bioinforbaidu'

如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com
或关注微信公众号'bioinforbaidu'或'生信摆渡'后台回复
***************************


***************************
Downloadding ...
Getting video information, this may take 1 ~ 2 minutes.
Maybe more, just wait.
***************************

site:                Bilibili
title:               周杰伦秘密花园扒带伴奏！既然原版的不够清晰，那就自己做一个吧！
stream:
    - format:        dash-flv480
      container:     mp4
      quality:       清晰 480P
      size:          16.2 MiB (16963444 bytes)
    # download-with: you-get --format=dash-flv480 [URL]

Downloading 周杰伦秘密花园扒带伴奏！既然原版的不够清晰，那就自己做一个吧！.mp4 ...
 100% ( 16.2/ 16.2MB) ├████████████████████████████████████████┤[2/2]    8 MB/s
Merging video parts... Merged into 周杰伦秘密花园扒带伴奏！既然原版的不够清晰，那就自己做一个吧！.mp4

Downloading 周杰伦秘密花园扒带伴奏！既然原版的不够清晰，那就自己做一个吧！.cmt.xml ...


***************************
If you have any question, please send mail to jhaowong1998@sina.com
Or follow wechat official account 'bioinforbaidu'

如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com
或关注微信公众号'bioinforbaidu'或'生信摆渡'后台回复
***************************


***************************
If you have any question, please send mail to jhaowong1998@sina.com
Or follow wechat official account 'bioinforbaidu'

如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com
或关注微信公众号'bioinforbaidu'或'生信摆渡'后台回复
***************************


***************************
Converting mp4 to mp3, file will save to 'video/get_video_tmp_95c38e25-35a2-4d15-a04f-13a9c88c79c9
***************************


***************************
If you have any question, please send mail to jhaowong1998@sina.com
Or follow wechat official account 'bioinforbaidu'

如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com
或关注微信公众号'bioinforbaidu'或'生信摆渡'后台回复
***************************


***************************
Cutting mp3, file will save to'video/get_video_tmp_95c38e25-35a2-4d15-a04f-13a9c88c79c9'
***************************

Getting danmaku ...

***************************
mp4 file will be deleted!
***************************


***************************
Finished!
Exacute 'shell.exec("video")' to open out directory.
***************************
```

结果：

![image-20231030180427334](https://raw.githubusercontent.com/JiahaoWongg/picBed/main/202311141048309.png)

看看弹幕：

```
拜托你穿双鞋啊
进入秘密花园～
来了来了
哦哦哦
贝斯跟七里香一样吗？
借力使力
1.5更欢快
1.25倍 太欢快了
n'p
罢了？你是什么啊 还罢了？这歌随便拿出来不吊打乐坛啊？
感谢up主
无敌啊
我的主题曲续作罢了
《乌克丽丽》可以对着唱
很酷
啊啊复苏
是否都一样
666
厉害
请问作者这是什么乐器音色呢？还有它的鼓点节奏型。
哭了
6啊
好样的，爱了爱了，比心！！！！！
简谱哪里有？
啊啊啊，终于找到了大神的牛掰制作
感谢up呀
舒呼
大爱！
1，25好听
可以用七里香高潮唱出来，旋律要拖音跟上beet
大神
二倍速绝了
啦啦啦啦啦啦啦啦
上传网易云！
感恩
爱了
哦啊啊啊啊啊啊啊啊啊
6
谢谢！
铃声制作
我想下载
一人血书上床网易云
舒服
水果大佬
厉害
来了鑫天王
你币有了
周杰伦的作曲令到无论谁来编曲都是那么好听
差点味
66666
发给我
有mp3
轻功进步多了
为什么要唱呢就这样一直放着多好
谢谢up
鑫天王 牛P
厉害
和南拳妈妈东山再起的编曲很像
听出了梦想启动的感觉，和弦估计一样
下次使用乾坤大挪移，记得穿鞋啊～
巨好听
不能加人生吗
6666
放在现在旋律吊打
有点像晴天娃娃
乾坤大挪移
调音很好
这是FL studio吗
我欧我欧
cc98过来的
我还以为是我的广告
可以唱布拉格广场哎哈哈哈
听见下雨的声音？
万岁
麻烦你下次穿双鞋啊
投币了
哭了 感谢up 一直想要高音质干净版《秘密花园》
谢谢阿婆主
666666666666
干申大那多？
杰迷人均神仙系列
是乾坤大挪移
啊啊有下载吗
好听到炸~
啊啊啊啊啊啊啊啊！！！！
天，瞬间被拉回10年前的春天
想要mp3!哭起来
把宿主学明白一个就能看懂了
喔哦喔哦
杰伦为什么不把这首歌拿出来呢？
秘密花园 超好听 就是杰伦没发
哦哦 呜 哦哦
一直想要这个完全版。。
66666
鑫天王牛逼
非常感谢
哇，谢谢up了
幹伸大那多
鑫天王，呜呜呜
音质，哭了
厉害了
土耳其的冰淇淋能扒吗
完全看不懂
麦天王牛皮
看不懂，但是感觉挺厉害的
好听
```



#### 多视频批量下载

首先生成批量下载配置文件, out_dir若未指定则默认会在当前文件夹下生成，并自动打开

```R
get_video_multi(prepare = TRUE)
```

每一行是单个视频的下载信息，需要设为TRUE的填1即可，示例如下

| url          | out_name                         | mp3  | start   | end     | remove.mp4 | danmu |
| ------------ | -------------------------------- | ---- | ------- | ------- | ---------- | ----- |
| BV1mJ411K7uL | 周杰伦-反方向的钟(扒带)          | 1    | 0:00:02 | 0:03:10 | 1          | 1     |
| BV1k7411z7er | 周杰伦-听见下雨的声音-Live(扒带) | 1    |         |         |            |       |
| BV1bT4y1c7Gw | 周杰伦-心雨(扒带)                | 1    | 0:00:00 | 0:04:30 | 1          | 1     |
| BV1dt411a7FX | 周杰伦-秘密花园(扒带)            | 1    |         |         |            |       |
| BV1AJ411x74M | 周杰伦-飘移(扒带)                |      |         |         |            | 1     |

然后就可以开始运行了，如果上面指定out_dir，这里仍需指定：

```
> get_video_multi()

***************************
'out_dir' not specific! Use current directory D:/BaiduSyncdisk/02_Study/R_build/build/rbilidown as out.
***************************


***************************
5 video to download!
***************************


***************************
Downloadding multi videos 1/5 ...
***************************

url: BV1mJ411K7uL
out_dir: D:/BaiduSyncdisk/02_Study/R_build/build/rbilidown
out_name: 周杰伦-反方向的钟(扒带)
mp3: TRUE
start: 0:00:02
end: 0:03:10
remove.mp4: TRUE
danmu: TRUE

***************************
If you have any question, please send mail to jhaowong1998@sina.com
Or follow wechat official account 'bioinforbaidu'

如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com
或关注微信公众号'bioinforbaidu'或'生信摆渡'后台回复
***************************


***************************
Downloadding ...
Getting video information, this may take 1 ~ 2 minutes.
Maybe more, just wait.
***************************

site:                Bilibili
title:               周杰伦编曲扒带第一张专辑《反方向的钟》编曲扒带
stream:
    - format:        dash-flv480
      container:     mp4
      quality:       清晰 480P
      size:          24.0 MiB (25131876 bytes)
    # download-with: you-get --format=dash-flv480 [URL]

Downloading 周杰伦编曲扒带第一张专辑《反方向的钟》编曲扒带.mp4 ...
 100% ( 24.0/ 24.0MB) ├████████████████████████████████████████┤[2/2]   13 MB/s
Merging video parts... Merged into 周杰伦编曲扒带第一张专辑《反方向的钟》编曲扒带.mp4

Downloading 周杰伦编曲扒带第一张专辑《反方向的钟》编曲扒带.cmt.xml ...


***************************
If you have any question, please send mail to jhaowong1998@sina.com
Or follow wechat official account 'bioinforbaidu'

如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com
或关注微信公众号'bioinforbaidu'或'生信摆渡'后台回复
***************************


***************************
If you have any question, please send mail to jhaowong1998@sina.com
Or follow wechat official account 'bioinforbaidu'

如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com
或关注微信公众号'bioinforbaidu'或'生信摆渡'后台回复
***************************


***************************
Converting mp4 to mp3, file will save to 'D:/BaiduSyncdisk/02_Study/R_build/build/rbilidown/get_video_tmp_60e84bd1-0a23-4a91-978f-7b461120f4d5
***************************


***************************
If you have any question, please send mail to jhaowong1998@sina.com
Or follow wechat official account 'bioinforbaidu'

如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com
或关注微信公众号'bioinforbaidu'或'生信摆渡'后台回复
***************************


***************************
Cutting mp3, file will save to'D:/BaiduSyncdisk/02_Study/R_build/build/rbilidown/get_video_tmp_60e84bd1-0a23-4a91-978f-7b461120f4d5'
***************************

Getting danmaku ...

***************************
mp4 file will be deleted!
***************************


***************************
Finished!
Exacute 'shell.exec("D:/BaiduSyncdisk/02_Study/R_build/build/rbilidown")' to open out directory.
***************************

此处省略一万字。。。


***************************
Downloadding multi videos 5/5 ...
***************************

url: BV1AJ411x74M
out_dir: D:/BaiduSyncdisk/02_Study/R_build/build/rbilidown
out_name: 周杰伦-飘移(扒带)
mp3: FALSE
start:
end:
remove.mp4: FALSE
danmu: TRUE

***************************
If you have any question, please send mail to jhaowong1998@sina.com
Or follow wechat official account 'bioinforbaidu'

如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com
或关注微信公众号'bioinforbaidu'或'生信摆渡'后台回复
***************************


***************************
Findding best quality format ...
Getting video information, this may take 1 ~ 2 minutes.
Maybe more, just wait.
***************************


***************************
Found best quality format: 1080P
***************************


***************************
Downloadding ...
Getting video information, this may take 1 ~ 2 minutes.
Maybe more, just wait.
***************************

site:                Bilibili
title:               周杰伦《飘移》编曲扒带
stream:
    - format:        flv
      container:     flv
      quality:       高清 1080P
      size:          24.8 MiB (25953842 bytes)
    # download-with: you-get --format=flv [URL]

Downloading 周杰伦《飘移》编曲扒带.flv ...
 100% ( 24.8/ 24.8MB) ├████████████████████████████████████████┤[1/1]    0  B/s

Downloading 周杰伦《飘移》编曲扒带.cmt.xml ...


***************************
If you have any question, please send mail to jhaowong1998@sina.com
Or follow wechat official account 'bioinforbaidu'

如果你遇到任何问题, 请发邮件至jhaowong1998@sina.com
或关注微信公众号'bioinforbaidu'或'生信摆渡'后台回复
***************************


***************************
Converting flv to mp4, file will save to 'D:/BaiduSyncdisk/02_Study/R_build/build/rbilidown/get_video_tmp_315d0b03-46c0-4aa6-826a-307723a4fd71
***************************

Getting danmaku ...

***************************
Finished!
Exacute 'shell.exec("D:/BaiduSyncdisk/02_Study/R_build/build/rbilidown")' to open out directory.
***************************


***************************
All video download succeed!
***************************
```



结果如下：

![image-20231114104836017](https://raw.githubusercontent.com/JiahaoWongg/picBed/main/202311141048204.png)

肥肠滴方便~s