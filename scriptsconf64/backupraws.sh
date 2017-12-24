rm -f raws/tmp.rwj
ls -t raws/*.raw |awk '{
	#print $0
	#cmd="./appendData.sh"  " " $1 "_" $2 "_" $3  "_" $4  "_" $5 " raws/tmp.rwj" 
	cmd="./appendData.sh"  " " $0  " raws/tmp.rwj" 
	system (cmd)
}'

echo ; echo Remove ? [ENTER] ; read
rm -f raws/*.raw
