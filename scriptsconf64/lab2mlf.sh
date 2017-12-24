#cmd="../htk/HTKTools/HERest -T 7 -C configtrain.txt -t 250.0 150.0 1000.0 -S train.scp -H hmm0/macros -H hmm0/hmmdefs -M hmm1 phonems.txt"
#echo $cmd; eval $cmd;


#f=../datas/cyr/0.lab

echo "#!MLF!#" > words.mlf

for pref in `cat sfstrain.lst | sed s/.sfs// `
do
	
	echo "\"$pref.lab\"" >> words.mlf 
	for ph in `cat $pref.lab | cut  -f 3 -d " "`
	do
		echo $ph >> words.mlf
	done
	echo . >> words.mlf
done