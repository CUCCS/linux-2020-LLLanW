# 实验二：vimtutor学习  

## 实验要求：自学vimtutor的使用  

## 实验环境：Ubuntu 18.04，asciinema  

## 实验前配置  

1.安装asciinema

>sudo apt install asciinema  

![安装](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap02_exp/img/安装asciinema.PNG)

2.关联asciinema  

>asciinema auth  

![建立连接](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap02_exp/img/asciinema建立连接.PNG)

## 自学视频

[第一讲自学视频](https://asciinema.org/a/SdaW79YohTYQYI4MdyRL3HTkl)  

[第二讲自学视频](https://asciinema.org/a/qdpdVyXIwjsKCFreEht94ZaOV)  

[第三讲自学视频](https://asciinema.org/a/uL4ah3gHmOte3sdJUd2QysqGR)  

[第四讲自学视频](https://asciinema.org/a/DyCQ57Y3iEltjlrX4MrlPr7yl)  

[第五讲自学视频](https://asciinema.org/a/p2vibf74wGChQz8QbpimFmFhH)  

[第六讲自学视频](https://asciinema.org/a/L0j20JG1OtZQdDwGVR6o7ah7b)  

[第七讲自学视频](https://asciinema.org/a/mPaSmbfgo361OFVGBvvJgDmAP)  

## 自查清单  

* **你了解vim有哪几种工作模式**  

    1.一般模式（Normal）：在其他模式中按esc键,即可转换至一般模式  
    2.编辑模式（Insert）：按下i/I/o/O/a/A可进入编辑模式，对文本进行修改  
    3.替换模式（Replace）：按下R键进入，与编辑模式不同的是，键入的字符直接替换当前字符  
    4.可视化模式（visual）：按下v可进入可视化模式，此时可对文本高亮处理  
&nbsp;
* **Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行？**  

    1.向下移动十行：10j。或输入数字x+10，再按下G（x为当前行数，可由CTRL+G查询）  
    2.快速移动到文件开始行：gg  
    3.快速移动到文件结束行：G  
    4.移动到文件中的第N行：输入N，再输入G  
&nbsp;
* **Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？**  

    1.删除单个字符：x  
    2.删除单个单词：dw  
    3.从当前光标删除到行尾：d$  
    4.删除单行：dd  
    5.删除从当前行下数N行：Ndd  
&nbsp;
* **如何在vim中快速插入N个空行？如何在vim中快速输入80个-？**  

    1.插入N个空行：  
    i.向下插入：80o/80[ i/a ]+ENTER  
    ii.向上插入：80O  
    2.快速输入80个-：80[ i/a ]-  
&nbsp;
* **如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作？**  

    1.撤销最近一次编辑操作：u  
    2.重做最近一次被撤销的操作：CRTL+r  
&nbsp;
* **vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢？**  

    1.剪切粘贴单个字符：x+p 或 d+p  
    2.剪切粘贴单个单词：dw+p  
    3.剪切粘贴单行：dd+p  
    4.复制粘贴：键入v进入可视化模式，选中要复制的内容，键入y，esc退出到一般模式后，键入p粘贴  
&nbsp;
* **为了编辑一段文本你能想到哪几种操作方式（按键序列）？**  

    1.插入类操作：  
    i. a/A:a在光标后添加文本，A在一行后添加文本  
    ii. i:在光标前插入文本  
    iii. :r FILENAME:在当前文件中插入另外文件的内容  
    iiii. o/O:o插入到光标下方一行，O插入到光标上方一行  
    &nbsp;
    2.替换类操作：  
    R：将光标位置文本替换为键入文本  
    &nbsp;
    3.删除类操作：  
    i. x:删除光标所在位置字符  
    ii. dNw:从光标处删除至N个单词的末尾（不包括第一个字符）  
    d$:从光标处删除到行末  
    de:从光标处删除到单词末尾，包括最后一个字符  
    iii. Ndd:删除N行内容  
    &nbsp;
    4.撤销类操作：  
    i. u：撤销上一步操作  
    ii. CTRL+R：重做撤销  
    &nbsp;
    5.复制粘贴类操作  
&nbsp;

* **查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法？**

    可同时查看：CTRL+G  
&nbsp;
* **在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换？**  

    1.方法：/关键字  
    2.忽略大小写：:set ic（不忽略大小写：:set noic）  
    3.搜索结果高亮显示：set hls is  
    4.批量替换：:%s/old/new/g  
&nbsp;
* **在文件中最近编辑过的位置来回快速跳转的方法？**

    1.向前：CTRL+o  
    2.向后：CTRL+i  
&nbsp;
* **如何把光标定位到各种括号的匹配项？例如：找到(, [, or {对应匹配的),], or }**  

    将光标移动到要匹配的括号前，键入%  
&nbsp;
* **在不退出vim的情况下执行一个外部程序的方法？**  

    键入:!+命令  
&nbsp;
* **如何使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法？如何在两个不同的分屏窗口中移动光标？**  

    1.使用内置帮助：:help  
    2.分屏移动光标：CTRL+w  

## 注意点  

1.不要把命令行窗口开得太大，录制过程中不要改变窗口大小  
2.阅读文本时，注意区分句中“：”是否为需要键入的命令  
