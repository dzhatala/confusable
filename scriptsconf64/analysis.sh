tgt="../results/test.sfs"
#wav=../datas/mito/2014-12-31-03-12-02.wav
oriph=../datas/mito/2014-12-31-03-12-02.lab

newph=../results/2014-12-31-03-12-02.recph

neww=../results/2014-12-31-03-12-02.recw

ori=../datas/mito/2014-12-31-03-12-02.sfs

rm -f $tgt
cp $ori $tgt

#hed="/cygdrive/c/Program\ Files/SFS/Program/hed.exe -n $tgt"
#eval $hed

cmd="/cygdrive/c/Program\ Files/SFS/Program/anload -h  $oriph $tgt"
#eval $cmd


cmd="/cygdrive/c/Program\ Files/SFS/Program/anload -h  $newph $tgt"
eval $cmd

cmd="/cygdrive/c/Program\ Files/SFS/Program/anload -h  $neww $tgt"
eval $cmd

echo "check $tgt !"
#$hed -n ../results/test.sfs
	