#aligning new lab for existing wav file
#

#if [ $1 == "" ] 
#then
#		return 
#	goto error:
#fi

#echo $1
#read
#usage : nlabforwav.sh x.wav
#datadir=../datas/cyr
HVITE=../../htk64/htk/HTKTools/HVite
datadir=`cat datadir.txt`
echo nlabforwav:datadir=$datadir
#hmmdir=hmm12
hmmdir=hmm16
phonems=triphones2
dic=$datadir/words.dic
tgtdir=../naligned
tgtext=alg
p1=`echo $1 | awk '{
			
			#print $1
			i1 = index ($1,".wav");
			prefix=substr($1,1,i1-1);
			print prefix 
		}
	'`
#echo $p1
p2=`echo $p1 | awk '{
			
		#print $1
		#next
		#print p1
		i1 = index ($1,"/");
		prefix=$1
		while (i1>0){
			#print i1
			prefix=substr (prefix,i1+1,length(prefix));
			#print prefix
			i1 = index (prefix,"/");
		}
		
		#prefix=substr($1,1,i1-1);
		#i2=index(prefix,".wav");
		#prefix=substr(prefix,1,i2-1);
		print prefix 
	}
	'`
#echo $p2 ; read
#echo $p2 ; read
#echo $mfc
cmd="../htk/HTKTools/HCopy -T 1 -C configcopy.txt $1 $p1.mfc"
echo $cmd; eval $cmd


cp /dev/null nlabalign.scp
echo $p1.mfc >> nlabalign.scp
mkdir -p $tgtdir
#aligning
#boundary=-b SIL
cmd="$HVITE -T 1 -y $tgtext.3 -l '*' $boundary -I nlab.mlf -m -o SW -C config -a -H $hmmdir/macros \
 -H $hmmdir/hmmdefs  -l $tgtdir  \
  -S nlabalign.scp $dic $phonems"

echo $cmd; eval $cmd
echo [Please create target SFS in $1 directory ! [ENTER]] ; read 
cmd="./tri2mono.awk $tgtdir/$p2.$tgtext.3 "
echo "$cmd ==> $tgtdir/$p2.alg"
eval $cmd > $tgtdir/$p2.alg


#anload="../hmm_sfs_tutorial/hmm_sfs_tutorial/anload.exe"
anload="../hmm_sfs_tutorial/hmm_sfs_tutorial/anload.exe"
anload="./anload" 
cmd="$anload -h -t phones  $tgtdir/$p2.alg $p1.sfs"
echo 
echo $cmd ; eval $cmd
