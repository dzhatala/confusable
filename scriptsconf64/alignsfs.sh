datadir=../datas/cyr
# echo
 echo aligning ...

  #../htk/HTKTools/HVite -T 1 -l '*' -I words.mlf -o SW -C config -a -H hmm7/macros \
 #-H hmm7/hmmdefs  -i aligned.mlf -L $datadir -y aligned \
 # -S train.scp phone1.dic monophones1


output=../aligned
mkdir -p ../aligned
  ../htk/HTKTools/HVite -T 1  -l $output -I words.mlf -o SW -C config -a -H hmm7/macros \
 -H hmm7/hmmdefs   -L $datadir -y aligned \
  -S $train.scp phone1.dic monophones1
 
  
 
 read

