#../htk/HTKTools/HParse gram wdnet 
#../htk/HTKTools/hsgen -n 5 wdnet dict > s1.txt
#../htk/HTKTools/hsgen -n 5  wdnet dict > s2.txt
#../htk/HTKTools/hsgen -n 5  wdnet dict > s3.txt
#for y in 1 2 3 4 5 6 7 8 9
for x in 0
do
	for y in 1 2 3 4 5 6 7 8 9 
	do
		echo ../htk/HTKTools/hsgen -n 1  wdnet dict \> ../datas s$x$y.txt
		../htk/HTKTools/hsgen -n 1  wdnet dict > ../datas/s$x$y.txt
	done
done
#echo ../htk/HTKTools/hsgen -n 5  wdnet dict > s3.txt
#../htk/HTKTools/hsgen -n 5  wdnet dict > s3.txt
