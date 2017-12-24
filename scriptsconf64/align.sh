#datadir=../datas/mito
# echo

echo monophone aligning ...

  ../htk/HTKTools/HVite -T 1 -l '*' -I words.mlf -o SW -C config -a -H hmm7/macros \
 -H hmm7/hmmdefs  -i aligned.mlf -L $datadir -y lab \
  -S train.scp phone1.dic monophones1

 read

