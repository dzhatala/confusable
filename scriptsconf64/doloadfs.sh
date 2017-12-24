# doloadsfs.sh - load scribe data into new SFS files
for s in c e f h m 
do
	#echo $s
	for f in 0001 0002 0003 0004
	do
	echo ma$s.$f.sfs
	./hed -n ma$s.$f.sfs
    ./slink -isp -f 20000 mt/ma$s/a${s}pa$f.pes ma$s.$f.sfs
	./anload -S mt/ma$s/a${s}pa$f.pea ma$s.$f.sfs
	./anmap -m svumap.txt ma$s.$f.sfs
	#exit
	done
done
