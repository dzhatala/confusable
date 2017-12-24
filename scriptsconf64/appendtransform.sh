
ck0=`echo "$1" | grep .sfs`
#echo "NOT_FIXED to accomodate cw and mono_s triph_s"
if [ "$ck0" == "" ]; then
  echo USAGE: appendtransform.sh complete_path_sfs_file
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
ck1=`cat adapt.scp | grep $x.mfc`
#echo ; echo "ck1..."
if [ "$ck1" != "" ]; then
  echo "$x ALREADY_EXIST in adapt.scp"
  ADAPTSCP_EXIST="TRUE"
fi



mkdir -p transform


filename=`echo $1| sed 's/.sfs//' |gawk '{
	#print $0
	nums=split($0,ar,"/")
	#print nums " " ar[1]  " " ar[2]
	print ar[nums]
}'`
echo "filename=$filename "


if [ "$FAILED" == "" ]; then

	x=`echo $1 | sed 's/.sfs//'`
	#echo "prefix is $x"

	if [ "$ADAPTSCP_EXIST" == "" ]; then
		cmd="../datas/mono_s/$filename.mfc >> adapt.scp" ;echo $cmd
		echo "../../datas/mono_s/$filename.mfc" >> adapt.scp
		echo "../../datas/triph_s/$filename.mfc" >> adapt.scp
	fi
	cmd="../htk/HTKTools/HCopy -T 7 -C configcopy.txt $x.wav $x.mfc" ;echo $cmd
	eval $cmd
		
	anlist="./anlist"
	cmd="$anlist -h  -o ../../datas/transform/$filename.lab $x.sfs " ;echo $cmd
	eval $cmd
	
	mkdir -p ../../datas/transformlab3
	../htk/HTKTools/HLEd -T 3    -l ../../datas/transformlab3   mktri.led ../../datas/transform/*.lab
	#../htk/HTKTools/HLEd -T 3    -i wintri.mlf mktri.led $datadir/*.lab


fi

echo " cw_append_sfs ? [ENTER]" ; read
./cw_appendsfs.sh $1
