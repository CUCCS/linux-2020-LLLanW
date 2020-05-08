#!/bin/bash


function Top_100()
{
	echo -e "统计访问来源主机TOP100和分别对应出现的总次数"
	b=`awk -F '\t' '{a[$1]+=1;}END{for(i in a){print a[i],i;}}' ./web_log.tsv | sort -t " " -k 1 -n -r | head -n 100`
	echo "$b"
}

function Top_100_IP()
{
	echo -e "统计访问来源主机TOP100IP和分别对应出现总次数"
	b=`awk -F '\t' '{a[$1]+=1;}END{for(i in a){print a[i],i;}}' ./web_log.tsv | egrep '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}' | sort -t " " -k 1 -n -r | head -n 100`
	echo "$b"
}

function Top_100_URL()
{
	echo -e "统计最频繁被访问的URLTOP100"
	b=`awk -F '\t' '{a[$5]+=1;}END{for(i in a){print a[i],i;}}' ./web_log.tsv | sort -t " " -k 1 -n -r | head -n 100`
	echo "$b"

}

function Status()
{
	echo -e "统计不同响应状态码的出现次数和百分比"
	echo -e "状态码""\t""响应次数""\t""百分比"
	b=`awk -F '\t' '{if(length($6)<4){a[$6]+=1;sum+=1;}}END{for(i in a){print i,a[i],a[i]/sum;}}' ./web_log.tsv`
	echo "$b"
}

function Status_and_URL()
{
	echo -e "统计不同4XX状态码对应的TOP10URL和对应出现的总次数"
	echo -e "状态码""\t""URL""\t""总次数"
	b=`awk -F '\t' '{if($6==403){a[$5]+=1;}}END{for(i in a){print 403,i,a[i];}}' ./web_log.tsv | sort -t " " -k 3 -n -r | head -n 10`
	c=`awk -F '\t' '{if($6==404){d[$5]+=1;}}END{for(i in d){print 404,i,d[i];}}' ./web_log.tsv | sort -t " " -k 3 -n -r | head -n 10`
	echo "$b"
	echo "$c"
}

function Select_URL_Top_100()
{
	echo -e "给定URL输出TOP100访问来源主机"
	b=`awk -F '\t' '{if($5=="'$1'"){a[$1]+=1;}}END{for(i in a){print a[i],i}}' ./web_log.tsv | sort -t " " -k 1 -n -r | head -n 100`
	echo "$b"
}

function useage()
{
	echo "Useage: bash task3.sh [option]"
	echo "-a				show TOP100 from host"
	echo "-b				show TOP100 IP from host"
	echo "-c				show TOP100 URL from host"
	echo "-d				show different status code"
	echo "-e				show 4XX status code"
	echo "-f				show select URL TOP 100 from host"
	exit 0
}

while getopts 'f:abcdeh' OPT;do
	case $OPT in
		h)
			useage;;
		a)
			Top_100;;
		b)
			Top_100_IP;;
		c)
			Top_100_URL;;
		d)
			Status;;
		e)
			Status_and_URL;;
		f)
			Select_URL_Top_100 $OPTARG;;
	esac
done
