echo "./appendData.sh $1 $2"
dd if=$1	skip=32  >> $2


