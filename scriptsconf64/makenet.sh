datadir=`cat datadir.txt`
echo makenet:datadir=$datadir 
../htk/HTKTools/HParse.exe $datadir/gram-now.txt words.net
../htk/HTKTools/HParse.exe $datadir/gram-now.txt words-dotestsh.net
