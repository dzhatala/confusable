sync
sync
sync
ping localhost > /dev/null
 
src=hmm12
tgt=hmm13
mixf=mix.hed.cherry
phones=triphones1
mkdir -p $tgt
echo increasing mix 2 if any using $mixf
cmd="../htk/HTKTools/HHEd -T 1 -H $src/macros -H $src/hmmdefs -M $tgt $mixf $phones"
echo $cmd ; eval $cmd

echo train hmm14 ...
mkdir -p hmm14
../htk/HTKTools/HERest  -L ../trilab -T 1 -C config -I wintri.mlf -t 250.0 150.0 1000.0 -s stats \
-S train.scp -H hmm13/macros -H hmm13/hmmdefs -M hmm14 triphones1

cmd="cat triphones1 triphones2"
echo $cmd ;  cat triphones1 | sort | uniq > triphones2
echo sp>> triphones2
cat hmm0/master_sp2.txt >> hmm14/hmmdefs
#echo "Please fix sp.state2 using sil.state3 on hmm14/hmmdefs <ENTER>! " ;read
mkdir -p hmm15
#cp hmm14/* hmm15/*
../htk/HTKTools/HHEd -T 1 -H hmm14/macros -H hmm14/hmmdefs -M hmm15 sil2.hed triphones2

echo train hmm16 ...
mkdir -p hmm16
../htk/HTKTools/HERest -L ../trilab  -T 1 -C config -I wintri.mlf -t 250.0 150.0 1000.0 -s stats \
-S train.scp -H hmm15/macros -H hmm15/hmmdefs -M hmm16 triphones2

echo more train hmm16 ...
mkdir -p hmm16b

../htk/HTKTools/HERest -L ../trilab -T 1 -C config -I wintri.mlf -t 250.0 150.0 1000.0 -s stats \
-S train.scp -H hmm16/macros -H hmm16/hmmdefs -M hmm16b triphones2
../htk/HTKTools/HERest -L ../trilab  -T 1 -C config -I wintri.mlf -t 250.0 150.0 1000.0 -s stats \
-S train.scp -H hmm16b/macros -H hmm16b/hmmdefs -M hmm16 triphones2
../htk/HTKTools/HERest -L ../trilab  -T 1 -C config -I wintri.mlf -t 250.0 150.0 1000.0 -s stats \
-S train.scp -H hmm16/macros -H hmm16/hmmdefs -M hmm16b triphones2
../htk/HTKTools/HERest -L ../trilab  -T 1 -C config -I wintri.mlf -t 250.0 150.0 1000.0 -s stats \
-S train.scp -H hmm16b/macros -H hmm16b/hmmdefs -M hmm16 triphones2
ping localhost > /dev/null
cp stats hmm16/stats
