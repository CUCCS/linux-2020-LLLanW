#!/bin/bash

function compression()
{	
	for i in "$1"*.jpg;do
		fullname=$(basename "$i")
		filename=$(echo "$fullname" | cut -d . -f1)
		$(convert "$i" -quality "$2"% "$1/after_compress_$filename"."jpg")
	done
	echo "finished"
}

function compress_resolution()
{
	flist=`ls $1`
	for i in $flist;do
		case $(file $1/$i) in
			*jpg*)
				$(convert $1/$i -resize $2%x$2% "$1/compress_resolution_"$i);;
			*png*)
				$(convert $1/$i -resize $2%x$2% "$1/compress_resolution_"$i);;
			*svg*)
				$(convert $1/$i -resize $2%x$2% "$1/compress_resolution_"$i);;
			*)
				echo "can't handle with this format"
		esac
	done
	echo "finished"
}

function add_watermark()
{
	flist=`ls $1`
	for i in $flist;do
		{
			 $(convert -size 80x80 xc:none -fill grey \-gravity NorthWest -draw "text 10,10 $2" \-gravity SouthEast -draw "text 5,15 $2" \miff:- |\composite -tile - $1/$i  $1/watermark_$i)
		}
	done
	echo "finished"
}

function add_pre_name()
{
	flist=`ls $1`
	for i in $flist;do
            mv $1/$i "$1/$2"$i
	done
	echo "finished"
}

function add_succeed_name()
{
	flist=`ls $1`
	for i in $flist;do
		fullname=$(basename "$i")
	    filename=$(echo "$fullname" | cut -d . -f1)
		extension=$(echo "$fullname" | cut -d . -f2)
		mv $1/$i "$1/$filename$2"."$extension"
	done
	echo "finished"
}

function change_format()
{
	flist=`ls $1`
	for i in $flist;do
	    fullname=$(basename "$i")
	    filename=$(echo "$fullname" | cut -d . -f1)
	    $(convert $1/$i "$1/change_$filename"."jpg")
	done
	echo "finished"
}


function useage()
{
	echo "Usage: bash task1.sh"
	echo "-a				compress JPEG picture"
	echo "-b				compression of the resolution"
	echo "-c				add watermark"
	echo "-d				rename pre-name"
	echo "-e				rename succeed-name"
	echo "-f				change format to jpg"
	echo "-g				filepath"
}
dir=""
while [[ "$#" -ne 0 ]]; do
		case "$1" in
			"-g")
				dir="$2"
				shift 2
				;;

			"-a")
				if [[ "$2" != '' ]]; then
					compression "$dir" "$2"
					shift 2
				else
					echo "You need to put in a quality parameter"
				fi
				;;

			"-b")
				if [[ "$2" != '' ]]; then
					compress_resolution  "$dir" "$2"
					shift 2
				else
					echo "You need to put in a resize rate"
				fi
				;;

			"-c")
				if [[ "$2" != '' ]]; then
					add_watermark "$dir" "$2"
					shift 2
				else
					echo "You need to input a string to be embeded into pictures"
				fi
				;;

			"-d")
				if [[ "$2" != '' ]]; then
					add_pre_name "$dir" "$2"
					shift 2
				else
					echo "You need to input a prefix"
				fi
				;;

			"-e")
				if [[ "$2" != '' ]]; then
					add_succeed_name "$dir" "$2"
					shift 2
				else
					echo "You need to input a suffix"
				fi
				;;

			"-f")
				change_format "$dir"
				shift
				;;

			"-h")
				useage
				shift
				;;
			esac
	done
