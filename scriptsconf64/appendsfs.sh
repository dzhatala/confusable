#datadir=../datas/mito
#datadir=../../datas/dv3win8micarray

#datadir=../datas/cyr
echo "DEPRECTED DEPRECTED DEPRECTED DEPRECTED  use cw_appendsfs.sh"
echo "Append SFS only for NO new phone and No new microphone (VARIANCE KEEP)...[ENTER ? CTRL+C]" ; read

#echo ; echo "ck0..."
ck0=`echo "$1" | grep .sfs`
if [ "$ck0" == "" ]; then
  echo USAGE: appensfs.sh complete_path_sfs_file
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
echo using datadir=$datadir 	

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

	dir=hmm16
	echo "ENTER to train!" ; read
	cmd="./train.sh" ; echo $cmd
	eval $cmd
		
	

fi


if [ "$FAILED" == "asdfasfsafasd" ]; then
	cmd="echo $x.wav $x.mfc >> $x/codetr.scp"
	echo $cmd
fi
if [ "$ck1" == "asdfasdfs" ]; then
	echo test ;
fi

if [ "$FAILED" == "asdfasdfasdf" ]; then
	cmd="echo $datadir/$1.sfs	>> $datadir/sfstrain.lst"
	echo $cmd
	cmd="../htk/HTKTools/HCopy -T 7 -C configcopy.txt -S $x.wav"
	echo $cmd
	cmd="../htk/HTKTools/HCopy -T 7 -C configcopy.txt -S $x.wav"
	echo $cmd

	anlist="./anlist"
	cmd="$anlist -h -O $x.sfs"
	echo $cmd
fi
