
dir="$1"
tgtdir="$2"
if [ "$dir" == "" ]; then
	dir=hmm24
fi


if [ "$tgtdir" == "" ]; then
	tgtdir=hmm25
fi


echo merging cw.mlf ...
cat wintri.mlf > cw.mlf
cat cw2_add.mlf | sed 's/\#\!MLF\!\#//' >> cw.mlf
echo merging cw.scp ...
cat mfc_mono.scp > cw.scp
cat mfc_triph.scp >> cw.scp


cmd="../../htk/HTKTools/HERest  -T 1 -C config  -I cw.mlf -t 250.0 150.0 1000.0  \
  -S cw.scp -H $dir/allhmm   -M tmp_a cherrytrainphones"

  

echo $cmd ; 
echo [ENTER];read
eval $cmd


cmd="../../htk/HTKTools/HERest  -T 1 -C config  -I cw.mlf -t 250.0 150.0 1000.0  \
  -S cw.scp -H tmp_a/allhmm    -M $tgtdir cherrytrainphones"

echo $cmd ; 
echo [ENTER];read
eval $cmd
