datadir=`cat datadir.txt`
echo Make HMM for continous Word Recognition...:datadir=$datadir 
sdir=hmm16
tdir=clhmm
sphones=triphones2
tphones=cwtriphones
dict=$datadir/words.dic
hedf=mkc1.hed

mkdir -p $tdir
tmp="_tmp"
cmd="cp -r $sdir/* $sdir$tmp/" ; echo $cmd ; eval $cmd;
echo "cloning"
cat  $sphones | sort | uniq > tmp_triphones
cmd="../htk/HTKTools/HHEd -T 1 -H $sdir$tmp/macros -H $sdir$tmp/hmmdefs -M $tdir $hedf tmp_triphones"
echo $cmd ; eval $cmd
echo "[ENTER]"; read
cat $tdir/hmmdefs  | sed 's/\*-u+\*/center_u/' | sed 's/silst/silren/'\
| sed 's/\*-a+\*/center_a/' \
| sed 's/\*-i+\*/center_i/' \
| sed 's/\*-e+\*/center_e/' \
| sed 's/\*-o+\*/center_o/' \
| sed 's/b+a/center_b/'  \
| sed 's/d+u/center_d/'  \
| sed 's/i-g+a/center_g/'  \
| sed 's/u-j+u/center_j/'  \
| sed 's/t+i/center_t/'  \
| sed 's/i-k+a/center_k/'  \
| sed 's/a-p+i/center_p/'  \
| sed 's/i-c+a/center_c/'  \
| sed 's/i-m+a/center_m/'  \
| sed 's/i-n+d/center_n/'  \
| sed 's/a-l+i/center_l/'  \
| sed 's/i-r+i/center_r/'  \
| sed 's/i-z+e/center_z/'  \
| sed 's/u-y+u/center_y/'  \
| sed 's/o-s+o/center_s/'  \
| sed 's/u-w+a/center_w/'  \
| sed 's/a-h+i/center_f/'  \
| sed 's/f+o/center_h/'  \
| sed 's/e-ng/center_ng/'  \
| sed 's/a-ny+a/center_ny/'  \
 > $tdir/hmmdefs_fix01
#echo "[ENTER]" ; read
	
#echo "Converting labs [see log1.txt].. DO NOT CTRL+C ..."
#mkdir -p ../contrwtrilab
#../htk/HTKTools/HLEd -T 3 -l ../contrwtrilab    contw1.led $datadir/*.lab > log1.txt
#../htk/HTKTools/HLEd -T 3 -l ../../datas/mono_s -n cw2_add_0   -i cw2_add.mlf contw1.led $datadir/*.lab
#echo "[ENTER]" ; read


#echo "merging dictionary"
#sort $datadir/words.dic > words-sort.dic
#./mkcwdict.sh
#cmd="../htk/HTKTools/HDMan -g cw.ded -m cwnow.dicts words-sort.dic cw2.dic"
#echo $cmd ; eval $cmd

echo "creating new triphones in $tphones"
cp monophones1 tmp_triphones
cat tmp_triphones > new_cw_phones
#cp /dev/null new_cw_phones

cat cw_2add_phones >> new_cw_phones

sort new_cw_phones | uniq > new_cw_phones_tmp

cp new_cw_phones_tmp new_cw_phones
#../htk/HTKTools/HLEd  -i cw_wintri.mlf  mktri.led $datadir/*.lab
	
mkdir -p $tdir$tmp
#tdir=hmm16
cmd="../htk/HTKTools/HERest -T 1 -C config  -L ../contrwtrilab   -t 250.0 150.0 1000.0 -s stats \
-S mfc_mono.scp -S -H hmm7/hmmdefs -H $tdir/macros -H $tdir/hmmdefs_fix01 -M $tdir$tmp new_cw_phones"
#echo $cmd ; eval $cmd > logtrain.txt

cmd="../htk/HTKTools/HERest -T 1 -C config  -L ../contrwtrilab   -t 250.0 150.0 1000.0 -s stats \
-S train.scp -H $tdir$tmp/hmmdefs -H $tdir$tmp/macros -H $tdir$tmp/hmmdefs_fix01 -M $tdir new_cw_phones"
#echo $cmd ; eval $cmd > logtrain.txt
cat triphones2 cw_2add_phones | sort | uniq > cwtriphones
./cw_train.sh
