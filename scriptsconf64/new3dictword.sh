

if [ "$1" == "" ]; then
	echo usage:  ./new3dictword.sh WORD
fi

#mkdir -p ../../datas/triphones_found
echo $1 |  gawk ' { print tolower($1) }  ' > ./temp_new3.tmp ; 
./extract_triphone.awk ./temp_new3.tmp > ./temp_new3.lab
echo sil >> ./temp_new3.lab
#| sed 's/sil//' 
mkdir -p tmp
../htk/HTKTools/HLEd -T 3 -l ./tmp    extract.led ./temp_new3.lab 
#cat ./temp_new3.tmp
#sort ../../datas/triphones_found/alltriphones | uniq > ../../datas/triphones_found/alltriphones_sort_uniq.txt
unlined="$1	`cat ./tmp/temp_new3.lab`"

y=""
for x in $unlined
do
	#echo $x
	if [ "$x" !=  "sil" ]; then
		y="$y $x"
	fi
done
#echo $y
datadir=`cat datadir.txt`
echo "using datadir=$datadir"
echo "$y >> $datadir/words.dic"
echo $y >> $datadir/words.dic
