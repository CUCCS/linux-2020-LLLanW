#!/bin/bash

function age()
{
	echo -e "统计不同年龄区间范围"
	a=$(awk -F '\t' 'BEGIN{
	split("<20 20-30 >30",b)}
	{if($6<20)a[1]++;
		if($6>=20&&$6<=30)a[2]++;
			if($6>30)a[3]++}
				END{for(i in a)print a[i]}' ./worldcupplayerinfo.tsv)
	sum=0
	ages=($a)
	for i in $a;do
		sum=$(($sum+$i))
	done

	s=("<20" "20-30" ">30")
	echo -e 'age\tcount\tporpotion'
	for i in `seq 0 2`;do
		age=${ages[i]}
		p=`awk 'BEGIN{printf "%.2f\n",('${age}'/'$sum')}'`
		echo -e ${s[i]}\\t${age}\\t${p}
	done
	echo -e "\n"
}

function player_in_field()
{
	echo -e "统计不同场上位置的球员"
	c=$(awk -F '\t' 'BEGIN{
	split("Goalie Defender Midfielder Forward Défenseur",d)}
	{if($5=="Goalie")c[1]++;
		if($5=="Defender")c[2]++;
			if($5=="Midfielder")c[3]++;
				if($5=="Forward")c[4]++;
					if($5=="Défenseur")c[5]++}
						END{for(i in c)print c[i]}' ./worldcupplayerinfo.tsv)
	sum=0
	positions=($c)
	for i in $c;do
		sum=$(($sum+$i))
	done

	t=("Goalie" "Defender" "Midfielder" "Forward" "Défenseur")
	echo -e 'position\tcount\tporpotion'
	for i in `seq 0 4`;do
		position=${positions[i]}
		p=`awk 'BEGIN{printf "%.2f\n",('${position}'/'$sum')}'`
		echo -e ${t[i]}\\t${position}\\t${p}
	done
	echo -e "\n"
}

function find_max_min_name()
{
	echo -e "输出名字最长和最短的球员"
	echo `awk -F '\t' 'BEGIN{max=0}
	{if(length($9)>max){max=length($9);namemax=$9;}}
	END{print "名字最长的球员是",namemax}' ./worldcupplayerinfo.tsv`
	echo `awk -F '\t' 'BEGIN{min=999}
	{if(length($9)<min){min=length($9);namemin=$9};}
	END{print "名字最短的球员是",namemin}' ./worldcupplayerinfo.tsv`
	echo -e "\n"
	
}

function find_oldest_youngest_age()
{
	echo -e "输出年龄最大和最小的球员"
	echo `awk -F '\t' 'BEGIN{max=0}
	{if($6>max && length($6)<3){max=$6;maxage=$9;}}
	END{print "年龄最大的球员是",maxage,"年龄为",max}' ./worldcupplayerinfo.tsv`
	echo `awk -F '\t' 'BEGIN{min=99}
	{if($6<min){min=$6;minage=$9;}}
	END{print "年龄最小的球员是",minage,"年龄是",min}' ./worldcupplayerinfo.tsv`
	echo -e "\n"
}

function useage()
{
	echo "Useage: bash task2.sh [option]"
	echo "-a				show age range"
	echo "-b				show different player in field"
	echo "-c				show the max and min name"
	echo "-d				show the oldest and youngest player"
	exit 0
}

while getopts 'd:abch' OPT;do
	case $OPT in
		h)
			useage;;
		a)
			age;;
		b)
			player_in_field;;
		c)
			find_max_min_name;;
		d)
			find_oldest_youngest_age;;
	esac
done
