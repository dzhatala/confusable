#./dotest.sh
./makenet.sh

datadir=`cat datadir.txt`
echo dotesw:datadir=$datadir 
dir=hmm16
phonems=triphones2
dict=$datadir/words.dic

wip=0.0

cmd="../../htk/HTKTools/HDecode  -l ../results -y recw -T 1 -w words.net -C config.hdecode -H $dir/macros -H $dir/hmmdefs \
 -o S -S $datadir/test.lst $dict $phonems"
echo $cmd ; eval $cmd
