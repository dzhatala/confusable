# export.sh - copy scribe data into wavs files

#cp /dev/null codetr.scp
#cp /dev/null train.scp

#cp /dev/null  phones0.mlf

for s in c e f h m 
do
	#echo $s
	for f in 0001 0002 0003 0004
	do
	#./sfs2wav ma$s.$f.sfs
	#echo ma$s.$f.wav ma$s.$f.mfc >> codetr.scp
	#./anlist -h -O ma$s.$f.sfs
	#echo ma$s.$f.mfc >> train.scp
	
	
	done
done

