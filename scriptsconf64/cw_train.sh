
dir="$1"
tgtdir="$2"
phones="$3"

if [ "$dir" == "" ]; then
	dir=hmm16
fi

tmp="_tmp"


if [ "$tgtdir" == "" ]; then
	tgtdir=hmm17
fi

if [ "$phones" == "" ]; then
	phones=cwtriphones
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

cmd="../htk/HTKTools/HERest  -T 1 -C config  -I cw.mlf -t 250.0 150.0 1000.0 -s $tgtdir/stats \
  -S cw.scp -H $dir/macros -H $dir/hmmdefs -H $dir/hmmdefs_fix01 -M tmp_a $phones"

if [ "$1" == "" ]; then
	cmd="../htk/HTKTools/HERest  -T 1 -C config  -I cw.mlf -t 250.0 150.0 1000.0 -s $tgtdir/stats  \
  -S cw.scp -H hmm16/macros -H hmm16/hmmdefs -H clhmm/hmmdefs_fix01 -M tmp_a $phones"
	echo "first creation ????"	
fi

echo $cmd ; 
#echo [ENTER];read
eval $cmd

cmd="../htk/HTKTools/HERest  -T 1 -C config -I cw.mlf  -t 250.0 150.0 1000.0 -s $tgtdir/stats \
  -S cw.scp -H tmp_a/macros -H tmp_a/hmmdefs -H tmp_a/hmmdefs_fix01 -M $tgtdir $phones"
echo $cmd ; 
#echo [ENTER];read
eval $cmd
if [ "$dir" != "$tgtdir" ]; then
	if [ "$1" != "" ]; then
		if [ "$2" == "" ]; then
			echo "[REWRITE $dir ?? ]" ;read ; 
			cmd="../htk/HTKTools/HERest  -T 1 -C config -I cw.mlf -t 250.0 150.0 1000.0 -s $tgtdir/stats \
			  -S cw.scp -H $tgtdir/macros -H $tgtdir/hmmdefs -H $tgtdir/hmmdefs_fix01 -M $dir $phones"
			echo $cmd ; 
			echo [ENTER];read
			eval $cmd
		fi
	fi
fi
