#datadir=../datas/mito
#datadir=../../datas/dv3win8micarray

#datadir=../datas/cyr
datadir=`cat datadir.txt`
echo using datadir=$datadir 


echo "rm $datadir/*.lab? , CTRL+C to cancel"
read
rm -f $datadir/*.lab

anlist="wine32.sh ~/.wine/drive_c/htk/SFS/Program/anlist.exe	"

cp /dev/null codetr.scp 
cp /dev/null train.scp
y1=$datadir/sfstrain.lst
#echo $y1
for sfs in `cat $y1`
do
	#echo $sfs ; read
	p1=`echo $sfs | awk '{
			
			#print $1
			i1 = index ($1,".sfs");
			prefix=substr($1,1,i1-1);
			print prefix 
		}
	'`
	echo $p1.mfc >> train.scp
	echo $p1.wav $p1.mfc  >> codetr.scp
	
	cmd="$anlist -h -O $sfs"
	echo $cmd ; eval $cmd
done

cp codetr.scp $datadir/

for sfs in `cat $datadir/sfstest.lst`
do
	p1=`echo $sfs | awk '{
			
			#print $1
			i1 = index ($1,".sfs");
			prefix=substr($1,1,i1-1);
			print prefix 
		}
	'`
	#echo $p1.mfc >> $datadir/test.lst
	cmd="$anlist  -i an.01 -h -O $sfs"
	echo $cmd ; eval $cmd
	
done




