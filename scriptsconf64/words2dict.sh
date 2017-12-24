if [ "$1" == "" ]; then
	FAILED="first_param"
fi


if [ "$1" == "" ]; then
	FAILED="second_param"
fi


if [ "$FAILED" != "" ]; then
	echo usage: words2dict.sh wordsfiles htk_dicts_file0 htk_dicts_file1 htk_dicts_file2 ...
fi


if [ "$FAILED" == "" ]; then
	 
	 ./words2dict.awk $1 $2 $3 $4 $5
	 
fi


