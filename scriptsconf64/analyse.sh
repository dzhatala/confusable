
if [ "$1" == "" ]; then
	FAILED="FAILED NO RECW FILES" 
	echo "usage ./analyse.sh ../results/YOURFILES.recw"
fi





if [ "$FAILED" == "" ]; then

	cek1=`echo $1 | sed 's/recw//' | sed 's/..\/results//'`
	#echo $cek1
	ndl1=`cat ./nlab.mlf  | grep "$cek1"` 
	#echo $ndl1
	if [ "$ndl1" == "" ]; then
		
		FAILED="NO_ENTRY_FOUND"
		echo "NO $cek1 found in ./nlab.mlf"
	fi
fi


if [ "$FAILED" == "" ]; then

	cat nlab.mlf | sed 's/..\/..\/datas\/dv3win8micarray/..\/results/' > ../results/nlab.mlf

	cmd="../../htk/HTKTools/HResults -T 1 -I ../results/nlab.mlf wordslist.txt $1"
	echo $cmd; eval $cmd
	echo ; echo "Make Sure nlab.mlf contains TRUE transc. !!!"
	
fi

