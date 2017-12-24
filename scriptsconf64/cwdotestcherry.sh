
if [ "$1" != "" ]; then

	datadir=`cat datadir.txt`
	echo dotesw_wav:datadir=$datadir 
	sdir=hmm17
	dir0=hmm17_a
	dir1=hmm18
	dir2=hmm19
	dir3=hmm25
	monodir=hmm4
	phones0=cwtriphones
	phones="cherryphones"
	dict=cherry.dicts
	
	#P1="UNSET or do commment with # to not DO"
	echo "P1 set/unset ?  [ENTER]" ; read
	cat  ../../datas/triph_s/zcherry_*lab  $phones0 | cut -f 3 -d " " | sort | uniq >  cherrytrainphones
	./missingtriphones.awk  cwtriphones cherrytrainphones > cherrymissingphones
	
	cat monophones1 $phones0   | sort | uniq > clphones 
	
	echo [ENTER] ; read
	
	if [ "$P1" != "" ]; then
		cmd="../../htk/HTKTools/HHEd -T 1 -H $sdir/macros -H $sdir/hmmdefs -H $sdir/hmmdefs_fix01 -H $monodir/hmmdefs -M $dir0 -w allhmm empty.txt clphones"
		echo $cmd; eval $cmd;
		cmd="../../htk/HTKTools/HHEd -T 1  -H $dir0/allhmm -M $dir1 -w allhmm cherry01.hed clphones"
		echo [ENTER] ; read
		echo $cmd ; eval $cmd
		echo [ENTER] ; read
		./transform_train.sh
		
	fi

	dir=$dir2

	wip=`cat wip.txt`
	cp /dev/null tempwavetest.lst
	echo $1 > tempwavetest.lst
	grammar_f=" -s 5.0 "
	transform=" -J xforms mllr1 -J classes " 
	cmd="cat $dir/hmmdefs $dir/hmmdefs_fix01"
	echo "$cmd >  $dir/hmmdefs_join " ; eval $cmd >  $dir/hmmdefs_join

	cmd="../../htk/HTKTools/HParse $datadir/gram-android.txt net-cherry.net"
	echo $cmd ; eval $cmd	
	#echo [ENTER] ; read
	./net2words.sh net-cherry.net |sort | uniq > wordslist.txt
	# ./words2dict.sh wordslist.txt   cherry.dicts.1.cmd.opt | sort | uniq > cherry.dicts.1
	#./words2dict.sh wordslist.txt   cherry.dicts.1.num.opt | sort | uniq > cherry.dicts.1
	./words2dict.sh wordslist.txt   cherry.dicts.1.ltr.opt cherry.dicts.1.cmd.opt cherry.dicts.1.num.opt | sort | uniq > cherry.dicts.1
	
	#cat cherry.dicts.1.cmd_num_opt > cherry.dicts.1
	cmd="../htk/HTKTools/HDMan -n cherryphones cherry.dicts cherry.dicts.1" 
	echo $cmd ; eval $cmd
	
	
	if [ "$P1" != "" ]; then
		mkdir -p hmm23
		cmd="../../htk/HTKTools/HHEd -T 1  -H hmm19/allhmm -H hmm19/allhmm.novar -M hmm23 -w allhmm empty.txt cherrytrainphones"
		echo $cmd; 
		echo [ENTER] ; read ;
		eval $cmd;
		./transform.sh hmm23
		#./last_train.sh hmm23 hmm24
	
	fi

		cmd="../../htk/HTKTools/HHEd -T 1  -H hmm23/allhmm  -M hmm25 -w allhmm empty.txt cherryphones"
		echo $cmd; eval $cmd
	
	cmd="../../htk/HTKTools/HViteori  -o ST $wip -l ../results -y recw -T 1 -w net-cherry.net \
		$transform -C configcopy.txt -H $dir/macros -H $dir/hmmdefs_join \
	 -o S -S tempwavetest.lst  $dict $phones"
	cmd="../../htk/HTKTools/HViteori  -o ST $wip -l ../results -y recw -T 1 -w net-cherry.net \
		$transform -C configcopy.txt -H $dir3/allhmm  \
	 -o S -S tempwavetest.lst  $dict $phones"
	
	dir3=hmm25
	cmd="../../htk/HTKTools/HViteori  -o ST $wip -l ../results -y recw -T 1 -w net-cherry.net \
		$transform -C configcopy.txt -H $dir3/allhmm  \
	 -o S -S tempwavetest.lst  $dict $phones"
	echo $cmd ; 
	eval $cmd

	echo "ENTER" ; read ;
	echo "Create sfs ?" ; read


	anload="./anload"
	hed="./hed"
	anload="./anload"
	tgt=../results
	RECWS=""
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
		
		cmd="../../htk/HTKTools/HLEd -l $datadir -i test.mlf empty.led $tgt/$p1.recw" 
		#echo $cmd ; eval $cmd
		echo $tgt/$p1.recw > test.mlf
		cut -f 3 -d " " $tgt/$p1.recw >> test.mlf
		echo ; echo \"test.mlf\" Created for cw_nlabforwav.sh prototype!
		cmd="./tri2mono.awk   $tgt/$p1.recph3"
		#echo "$cmd ==> $tgt/$p1.recph" ; eval $cmd > $tgt/$p1.recph
		cmd="$anload -h   $tgt/$p1.recph $tgt/$p1.sfs"
		#echo $cmd ; eval $cmd
		cmd="$anload -h   $tgt/$p1.recph3 $tgt/$p1.sfs"
		#echo $cmd ; eval $cmd
	 done
	 
	 
 fi
 
