#./dotest.sh
./makenet.sh
#rm -f raws/*.raw
#./cleanraw.sh

datadir=`cat datadir.txt`
#echo doteswlive:datadir=$datadir ; echo "MIC ON? stereo 16k for measurement! -> mono after" ; read
dir=hmm17
dir2=clhmm
phonems=cwtriphones
dict=cwnow.dicts
net=words.net
wip=`cat wip.txt`
hvitelive="../../htk/HTKTools/HVite"
grammar_f="-s 5.0"
transform=" -J xforms mllr1 -J classes " 
cmd="$hvitelive   -g -T 1 $wip -H $dir/macros -H $dir/hmmdefs -H $dir/hmmdefs_fix01 $transform -C config2 $grammar_f -w $net $wip  $dict $phonems"
echo $cmd > cmd.arg
echo $cmd ; eval $cmd
 
