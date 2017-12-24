# cp mac.0001.sfs test1.sfs
# cp mac.0001.lab test1.lab
# cp mac.0001.mfc test1.mfc
# echo test1.mfc > test.lst
HTK341_DIR=../../htk64/htk
datadir=`cat datadir.txt`
echo dotest:datadir=$datadir 

dir=hmm16
#dir=hmm12
phonems=triphones2
dict=./triph1.dict


cp /dev/null $dict ;sync

for x in `cat triphones1`
do
	echo $x	$x >> $dict
done
#echo sil sp >> $dict
sync
#cat triph1.dict
#echo "test" ; read

cp /dev/null tempwavetest.lst
echo $1 > tempwavetest.lst

$HTK341_DIR/HTKTools/HBuild $dict triph1.net
cmd="$HTK341_DIR/HTKTools/HVite -l ../results -y recph3 -T 1 -w triph1.net -C configcopy.txt -H $dir/macros -H $dir/hmmdefs \
 -o S -S tempwavetest.lst $dict $phonems"
 echo $cmd ; eval $cmd

 # ./remove.exe  -i an.01  test1.sfs
 # ./remove.exe  -i an.02  test1.sfs
 # ./remove.exe  -i an.03  test1.sfs
 # ./anload -h test1.lab test1.sfs
 # ./anload -h test1.rec test1.sfs
 # ./ancomp.exe -r an.01 -t an.02 -f -m - test1.sfs | ./conmat -esl
