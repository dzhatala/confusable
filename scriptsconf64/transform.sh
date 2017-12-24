
dir0=hmm17

dir1=hmm25

if [ "$1" != "" ]; then
	dir1=$1
fi 

phones=cherrytrainphones
HTKTOOLS=../../htk64/htk/HTKTools
mkdir -p classes
cmd="../htk/HTKTools/HHEd -B -H $dir0/macros -H $dir0/hmmdefs -H $dir0/hmmdefs_fix01 -M classes regtree.hed $phones"
cmd="../htk/HTKTools/HHEd -B -H $dir0/macros -H $dir0/hmmdefs -H $dir0/hmmdefs_fix01 -M classes regtree.hed $phones"
cmd="$HTKTOOLS/HHEd -B -H $dir1/allhmm -M classes regtree.hed $phones"
echo $cmd ; eval $cmd ;
#echo [ENTER] ; read

labtarg="-L ../../datas/transformlab3"

mkdir -p xforms
cmd="../htk/HTKTools/HERest -T 1 -C config -C config.global -S adapt.scp $labtag   \
	-H $dir1/allhmm  -J classes -K xforms mllr1 -u a  \
	$phones" 
echo $cmd ; eval $cmd ;echo [ENTER] ; read

#HERest -a -C config -C config.rc -S adapt.scp -I adaptPhones.mlf ...
#-H hmm15/macros -u a -H hmm15/hmmdefs -J xforms mllr1 -K xforms mllr2  ...
#-J classes -h '*/%%%%%%_*.mfc' tiedlist

cmd="$HTKTOOLS/HERest -a -C config -C config.rc -S adapt.scp $labtag \
	-H $dir1/macros -H $dir1/hmmdefs -H $dir1/hmmdefs_fix01  -J xforms mllr1  -K xforms mllr2 -J classes \
	-u a  $phones "
#echo $cmd ; eval $cmd
