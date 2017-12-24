#./dotest.sh
./makenet.sh
rm -f *.raw

datadir=`cat datadir.txt`
echo "This is deprecated, use continous word version ..."
echo doteswlive:datadir=$datadir ; echo "MIC ON? stereo 16k for measurement! -> mono after" ; read
dir=hmm16
phonems=triphones2
dict=$datadir/words.dic

wip=`cat wip.txt`
hvitelive="../../htk/HTKTools/HVite"
cmd="$hvitelive   -g -T 1 $wip -H $dir/macros -H $dir/hmmdefs -C config2 -w words.net $wip -s 5.0 $dict $phonems"
echo $cmd ; eval $cmd
 
