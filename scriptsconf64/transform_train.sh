
dir="$1"
tgtdir="$2"
cldir="$4"
phones="$5"

if [ "$dir" == "" ]; then
	dir=hmm17_a
fi

if [ "$cldir" == "" ]; then
	cldir=hmm18
fi


tmp="_tmp"


if [ "$tgtdir" == "" ]; then
	tgtdir=hmm19
fi

if [ "$phones" == "" ]; then
	phones=cherrytrainphones
fi




echo more train $dir $tgtdir $phones ...[ENTER] ;read
mkdir -p "$tgtdir"
mkdir -p tmp_a 
mkdir -p tmp_b

echo merging cw.mlf ...
cat wintri.mlf > cw.mlf
cat cw2_add.mlf | sed 's/\#\!MLF\!\#//' >> cw.mlf
echo merging cw.scp ...
cat mfc_mono.scp > cw.scp
cat mfc_triph.scp >> cw.scp

echo removing variance from $cldir/allhmm
cmd="./rmvarhmm.awk $cldir/allhmm "
echo "$cmd > $cldir/allhmm.novar "  
eval $cmd > $cldir/allhmm.novar

cmd="../../htk/HTKTools/HERest  -T 1 -C config  -I cw.mlf -t 250.0 150.0 1000.0  \
  -S cw.scp -H $dir/allhmm -H $cldir/allhmm.novar -M tmp_a cherrytrainphones"

  
  

echo $cmd ; 
echo [ENTER];read
eval $cmd


cmd="../../htk/HTKTools/HERest  -T 1 -C config  -I cw.mlf -t 250.0 150.0 1000.0  \
  -S cw.scp -H tmp_a/allhmm -H tmp_a/allhmm.novar -M $tgtdir cherrytrainphones"

  echo $cmd ; 
echo [ENTER];read
eval $cmd
