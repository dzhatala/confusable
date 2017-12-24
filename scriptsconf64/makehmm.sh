sync
sync
sync
#ping localhost > /dev/null

#datadir=../datas/cyr
#datadir=../datas/mito
datadir=`cat datadir.txt`
source env.sh
HVITE=$HTKTOOLS_DIR/HVite
#cp configtrain.txt.cherry configtrain.txt
#cp configtrain.txt.ori configtrain.txt
mkdir -p hmm0
#cp proto_MFCC_0_D_A proto
cp proto_MFCC_D_A_0_Z proto
echo Calculating global variance, using ./proto  saved to hmm0/proto ...
$HTKTOOLS_DIR/HCompV -T 1 -C configtrain.txt -f 0.01 -m -S train.scp -M hmm0 proto

echo [ENTER] ;read
cat $datadir/*.lab | cut -f 3 -d " " | sort  | uniq | sed s/"\r"// > phonems.txt
#sync ; ping localhost > /dev/null

cp /dev/null hmm0/hmmdefs

for x in `cat phonems.txt`
do
	echo creating hmm $x
	#cat hmm0/master | sed s/master/$x/ >> hmm0/hmmdefs
	
	#since duplication is OK !!! then
	cat hmm0/proto | sed s/proto/$x/ >> hmm0/hmmdefs

done

#sync ; ping localhost > /dev/null
head -3 hmm0/proto > hmm0/macros ; head -3 hmm0/vFloors >> hmm0/macros ; read
#sync ; ping localhost > /dev/null

#echo "fix hmm0/macros using vFloor + proto please !"
#echo [ENTER!] ;read 


mkdir -p hmm1
echo creating hmms in hmm1 ... 
cmd="$HTKTOOLS_DIR/HERest -T 7 -C configtrain.txt  -t 250.0 150.0 1000.0 \
-S train.scp -H hmm0/macros -H hmm0/hmmdefs -M hmm1 phonems.txt"
echo $cmd ; eval $cmd

echo [ENTER!]
read 

mkdir -p hmm2
echo creating hmms in hmm2 ...
$HTKTOOLS_DIR/HERest -T 1 -C configtrain.txt  -t 250.0 150.0 1000.0 \
-S train.scp -H hmm1/macros -H hmm1/hmmdefs -M hmm2 phonems.txt

mkdir -p hmm3
echo creating hmms in hmm3 ...
$HTKTOOLS_DIR/HERest -T 1 -C configtrain.txt  -t 250.0 150.0 1000.0 \
-S train.scp -H hmm2/macros -H hmm2/hmmdefs -M hmm3 phonems.txt

mkdir -p hmm4
cp -r hmm3/* hmm4
cat hmm0/master_sp.txt >> hmm4/hmmdefs
echo "Please fix sp.state2 using sil.state3 on hmm4/hmmdefs <ENTER>! "
read
mkdir -p hmm5
cat phonems.txt > monophones1.tmp
echo sp >> monophones1.tmp
sort monophones1.tmp | uniq | sort > monophones1
#sync ; ping localhost > /dev/null

$HTKTOOLS_DIR/HHEd -T 1 -H hmm4/macros -H hmm4/hmmdefs -M hmm5 sil.hed monophones1

read

mkdir -p hmm6
echo creating hmms in hmm6 ...
$HTKTOOLS_DIR/HERest -T 1 -C configtrain.txt  -t 250.0 150.0 1000.0 \
-S train.scp -H hmm5/macros -H hmm5/hmmdefs -M hmm6 monophones1

read 
mkdir -p hmm7
echo creating hmms in hmm6 ...
$HTKTOOLS_DIR/HERest -T 1 -C configtrain.txt  -t 250.0 150.0 1000.0 \
-S train.scp -H hmm6/macros -H hmm6/hmmdefs -M hmm7 monophones1


echo creating phone1.dic
 cp /dev/null phone1.dic
 for ph in `cat monophones1`
 do
	echo $ph	$ph >> phone1.dic
 done
echo "in phone.dic remove sp sp to sp sil please !<ENTER>"
read
 $HTKTOOLS_DIR/HBuild phone1.dic phone1.net

