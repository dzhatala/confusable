
datadir=`cat datadir.txt`
echo dotesw_wav:datadir=$datadir 
dir=hmm17
dir2=clhmm
phonems=cwtriphones
dict=cwnow.dicts

wip=`cat wip.txt`
cp /dev/null tempwavetest.lst
echo $1 > tempwavetest.lst
grammar_f=" -s 5.0 "
transform=" -J xforms mllr1 -J classes " 
cmd="../../htk/HTKTools/HViteori $wip -l ../results -y recw -T 1 -w words.net $transform -C configcopy.txt -H $dir/macros -H $dir/hmmdefs \
 -H $dir/hmmdefs_fix01 -o S -S tempwavetest.lst  $dict $phonems"
echo $cmd /hmmdefs ; eval $cmd

echo "ENTER" ; read ;
echo "Create sfs ?" ; read


anload="./anload"
hed="./hed"
anload="./anload"
tgt=../results
 for prefix in `cat tempwavetest.lst`
 do
	
	x=`echo $prefix | sed 's/wav/sfs/'`
	echo "copying ..$x to $tgt"
	#rm -f $x; ping localhost > /dev/null
	$hed -n $x 
	cp $x $tgt/
	echo "ok ?" ;read;
	
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
	cmd="./slink -isp -f 16000 $prefix $tgt/$p1.sfs"
	echo $cmd ; eval $cmd

	cmd="$anload -h   $tgt/$p1.recw $tgt/$p1.sfs"
	echo $cmd ; eval $cmd
	
	cmd="./tri2mono.awk   $tgt/$p1.recph3"
	#echo "$cmd ==> $tgt/$p1.recph" ; eval $cmd > $tgt/$p1.recph
	cmd="$anload -h   $tgt/$p1.recph $tgt/$p1.sfs"
	#echo $cmd ; eval $cmd
	cmd="$anload -h   $tgt/$p1.recph3 $tgt/$p1.sfs"
	#echo $cmd ; eval $cmd
 done
 