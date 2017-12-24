./dotest.sh
./makenet.sh

datadir=`cat datadir.txt`
echo dotesw:datadir=$datadir 
dir=hmm16
phonems=triphones2
dict=$datadir/words.dic

wip=`cat wip.txt`

cmd="../htk/HTKTools/HVite  -l ../results -y recw -T 1 $wip -w words.net -C configtrain.txt -H $dir/macros -H $dir/hmmdefs \
 -o S -S $datadir/test.lst $dict $phonems"
echo $cmd ; eval $cmd
 
echo "will call  SFS, CTRL+C to exit" ; read

 #echo "123 abc" | sed 's/[0-9][0-9]*/& &/'
#anload="../hmm_sfs_tutorial/hmm_sfs_tutorial/anload.exe"
anload="./anload"
tgt=../results
 for prefix in `cat $datadir/test.lst`
 do
	
	x=`echo $prefix | sed 's/mfc/sfs/'`
	echo "copying ..$x to $tgt"
	cp $x $tgt/
	
	
	p1=`echo $x | awk '{
			
			#print $1
			i1 = index ($1,"/");
			prefix=$1
			while (i1>0){
				#print i1
				prefix=substr (prefix,i1+1,length(prefix));
				#print prefix
				i1 = index (prefix,"/");
			}
			
			#prefix=substr($1,1,i1-1);
			i2=index(prefix,".sfs");
			prefix=substr(prefix,1,i2-1);
			print prefix 
		}
	'`
	#echo $p1
	cmd="$anload -h   $tgt/$p1.recw $tgt/$p1.sfs"
	echo $cmd ; eval $cmd
	
	cmd="./tri2mono.awk   $tgt/$p1.recph3"
	echo "$cmd ==> $tgt/$p1.recph" ; eval $cmd > $tgt/$p1.recph
	cmd="$anload -h   $tgt/$p1.recph $tgt/$p1.sfs"
	echo $cmd ; eval $cmd
	cmd="$anload -h   $tgt/$p1.recph3 $tgt/$p1.sfs"
	echo $cmd ; eval $cmd
 done
 