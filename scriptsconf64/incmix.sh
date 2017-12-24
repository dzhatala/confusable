echo increasing mix ...
src=hmm12
tgt=hmm13
mixf=mix.hed
phones=triphones1
mkdir -p $tgt
cmd="../htk/HTKTools/HHEd -T 1 -H $src/macros -H $src/hmmdefs -M $tgt $mixf $phones"
echo $cmd ; eval $cmd

echo train hmm14 ...
mkdir -p hmm14
../htk/HTKTools/HERest -T 1 -C config -I wintri.mlf -t 250.0 150.0 1000.0 -s stats \
-S train.scp -H hmm13/macros -H hmm13/hmmdefs -M hmm14 triphones1

cmd="cp triphones1 triphones2"
echo $cmd ; eval $cmd
echo sp>> triphones2
cat hmm0/master_sp.txt >> hmm14/hmmdefs
echo "Please fix sp.state2 using sil.state3 on hmm14/hmmdefs <ENTER>! "
read
mkdir -p hmm15
../htk/HTKTools/HHEd -T 1 -H hmm14/macros -H hmm14/hmmdefs -M hmm15 sil2.hed triphones2

echo train hmm16 ...
mkdir -p hmm16
../htk/HTKTools/HERest -T 1 -C config -I wintri.mlf -t 250.0 150.0 1000.0 -s stats \
-S train.scp -H hmm15/macros -H hmm15/hmmdefs -M hmm16 triphones2


