
echo "dEPRECATED ? cw_train.sh ???[ENTER]" ; read
dir="$1"
tgtdir="$2"
phones="$3"

if [ "$dir" == "" ]; then
	dir=hmm16
fi

tmp="_tmp"


if [ "$tgtdir" == "" ]; then
	tgtdir=$dir$tmp
fi

if [ "$phones" == "" ]; then
	phones=triphones2
fi




echo more train $dir $tgtdir $phones ...[ENTER] ;read
mkdir -p "$tgtdir"

cmd="../htk/HTKTools/HERest -L ../trilab -T 1 -C config -I wintri.mlf -t 250.0 150.0 1000.0 -s $tgtdir/stats \
-S train.scp -H hmm16/macros -H hmm16/hmmdefs -M $tgtdir $phones"
echo $cmd ; eval $cmd

if [ "$2" == "" ]; then
cmd="../htk/HTKTools/HERest -T 1  -L ../trilab -C config -I wintri.mlf -t 250.0 150.0 1000.0 -s $tgtdir/stats \
-S train.scp -H $tgtdir/macros -H $tgtdir/hmmdefs -M hmm16 $phones"
echo $cmd ; eval $cmd

fi