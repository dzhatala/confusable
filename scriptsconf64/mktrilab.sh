#datadir=../datas/cyr
datadir=`cat datadir.txt`
echo datadir=$datadir
#../htk/HTKTools/HLEd -n triphones1 -i wintri.mlf  mktri.led $datadir/*.lab
mkdir -p ../trilab
rm -f ../trilab/*lab
../htk/HTKTools/HLEd -T 3    -l ../trilab   mktri.led $datadir/*.lab
../htk/HTKTools/HLEd -T 3    -i wintri.mlf mktri.led $datadir/*.lab
../htk/HTKTools/HLEd -T 3 -l ../../datas/triph_s -n triphones1   -i wintri.mlf mktri.led $datadir/*.lab
../htk/HTKTools/HLEd -T 3 -l ../../datas/triph_s -n triphones1    mktri.led $datadir/*.lab
../htk/HTKTools/HLEd -T 3 -l ../../datas/mono_s -n cw2_add_0   -i cw2_add.mlf contw1.led $datadir/*.lab
../htk/HTKTools/HLEd -T 3 -l ../../datas/mono_s -n cw2_add_0    contw1.led $datadir/*.lab
sync ; ping localhost > /dev/null
sort triphones1 > tmp.sort
uniq tmp.sort > triphones1 