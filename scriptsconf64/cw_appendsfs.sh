#datadir=../datas/mito
#datadir=../../datas/dv3win8micarray

#datadir=../datas/cyr
echo "Append SFS only for NO new phone and No new microphone (VARIANCE KEEP)...[ENTER ? CTRL+C]" ; read

#echo ; echo "ck0..."
ck0=`echo "$1" | grep .sfs`
if [ "$ck0" == "" ]; then
  echo USAGE: cw_appendsfs.sh complete_path_sfs_file
  FAILED="TRUE"
else
	echo OK
fi

if [ "$FAILED" == "" ]; then
	ck0=`ls -l $1 | grep $1`
	if [ "$ck0" == "" ]; then
	  echo "$1 NOT VALID"
	  FAILED="TRUE"
	fi
fi

datadir=`cat datadir.txt`
base="../../datas"
echo using datadir=$datadir base=$base	

x=`echo $1 | sed 's/.sfs//'`
ck1=`cat train.scp | grep $x.mfc`
#echo ; echo "ck1..."
if [ "$ck1" != "" ]; then
  echo "$x ALREADY_EXIST in $datadir/train.scp"
  TRAINSCP_EXIST="TRUE"
fi




ck1=`cat $datadir/codetr.scp | grep $x.mfc`
#echo ; echo "ck1..."
if [ "$ck1" != "" ]; then
  echo "$x ALREADY_EXIST in $datadir/codetr.scp"
  CODETR_EXIST="TRUE"
fi

filename=`echo $x| gawk '{
	#print $0
	nums=split($0,ar,"/")
	#print nums " " ar[1]  " " ar[2]
	print ar[nums]
}'`
echo "filename=$filename "
#echo [ENTER] ; read



ck1=`cat mfc_mono.scp | grep $filename.mfc`
#echo ; echo "ck1..."
if [ "$ck1" != "" ]; then
  echo "$x ALREADY_EXIST in mfc_mono.scp"
  MONOSCP_EXIST="TRUE"
fi

ck1=`cat mfc_triph.scp | grep $filename.mfc`
#echo ; echo "ck1..."
if [ "$ck1" != "" ]; then
  echo "$x ALREADY_EXIST in mfc_triph.scp"
  TRIPHSCP_EXIST="TRUE"
fi



if [ "$FAILED" == "" ]; then

	x=`echo $1 | sed 's/.sfs//'`
	#echo "prefix is $x"
	ck1=`cat $datadir/sfstrain.lst | grep $1`
	#echo ; echo "ck1..."
	if [ "$ck1" == "" ]; then
		echo "$x ALREADY_EXIST in $datadir/sfstrain.lst"
		cmd="$x.sfs	>> $datadir/sfstrain.lst" ;echo $cmd
		echo $x.sfs	>> $datadir/sfstrain.lst
	fi

	if [ "$CODETR_EXIST" == "" ]; then
		cmd="$x.wav $x.mfc >> $datadir/codetr.scp" ;echo $cmd
		echo $x.wav $x.mfc >> $datadir/codetr.scp
	fi
	cmd="../htk/HTKTools/HCopy -T 7 -C configcopy.txt $x.wav $x.mfc" ;echo $cmd
	eval $cmd
		
	anlist="./anlist"
	cmd="$anlist -h -O $x.sfs" ;echo $cmd
	eval $cmd
	
	cmd="./mktrilab.sh" ; echo $cmd 
	echo "./mktrilab.sh...  Wait !!! DO NOT press CTRL+C"
	eval $cmd > /dev/null
	
	if [ "$TRAINSCP_EXIST" == "" ]; then
			cmd="$x.mfc	>> train.scp" ;echo $cmd
			echo $x.mfc	>> train.scp
	fi		

	if [ "$MONOSCP_EXIST" == "" ]; then
			cmd="$base/mono_s/$filename.mfc	>> mfc_mono.scp" ;echo $cmd
			echo "$base/mono_s/$filename.mfc"	>> mfc_mono.scp
	fi		

	if [ "$TRIPHSCP_EXIST" == "" ]; then
			cmd="$base/triph_s/$filename.mfc	>> mfc_mono.scp" ;echo $cmd
			echo "$base/triph_s/$filename.mfc"	>> mfc_triph.scp
	fi		
	
	cmd="cp -v $x.mfc $base/triph_s/"
	echo $cmd ; eval $cmd;
	cmd="cp -v $x.mfc $base/mono_s/"
	echo $cmd ; eval $cmd;
	
	
	echo "ENTER to train!" ; read
	cmd="./cw_train.sh hmm17" ; echo $cmd
	eval $cmd

fi


