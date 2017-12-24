# cp mac.0001.sfs test1.sfs
# cp mac.0001.lab test1.lab
# cp mac.0001.mfc test1.mfc
# echo test1.mfc > test.lst

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

../htk/HTKTools/HBuild $dict triph1.net
cmd="../htk/HTKTools/HVite -l ../results -y recph3 -T 1 -w triph1.net -C configtrain.txt -H $dir/macros -H $dir/hmmdefs \
 -o S -S $datadir/test.lst $dict $phonems"
 echo $cmd ; eval $cmd

 # ./remove.exe  -i an.01  test1.sfs
 # ./remove.exe  -i an.02  test1.sfs
 # ./remove.exe  -i an.03  test1.sfs
 # ./anload -h test1.lab test1.sfs
 # ./anload -h test1.rec test1.sfs
 # ./ancomp.exe -r an.01 -t an.02 -f -m - test1.sfs | ./conmat -esl
