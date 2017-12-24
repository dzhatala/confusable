
dir0=hmm17
dir1=hmm17
dir2=hmm19
phones=cherryphones

mkdir -p classes
cmd="../htk/HTKTools/HHEd -B -H $dir0/macros -H $dir0/hmmdefs -H $dir0/hmmdefs_fix01 -M classes regtree.hed $phones"
#echo $cmd ; eval $cmd ;echo [ENTER] ; read

mkdir -p xforms
cmd="../htk/HTKTools/HERest -C config -C config.global -S adapt.scp -L ../../datas/transformlab3 \
	-H $dir1/macros  -H $dir1/hmmdefs -H $dir1/hmmdefs_fix01  -J classes -K xforms mllr1 -u a  \
	$phones" 
echo $cmd ; eval $cmd ;echo [ENTER] ; read

#HERest -a -C config -C config.rc -S adapt.scp -I adaptPhones.mlf ...
#-H hmm15/macros -u a -H hmm15/hmmdefs -J xforms mllr1 -K xforms mllr2  ...
#-J classes -h '*/%%%%%%_*.mfc' tiedlist

cmd="../htk/HTKTools/HERest -a -C config -C config.rc -S adapt.scp -L ../../datas/transformlab3  \
	-H $dir1/macros -H $dir1/hmmdefs -H $dir1/hmmdefs_fix01  -J xforms mllr1  -K xforms mllr2 -J classes \
	-u a  $phones "
#echo $cmd ; eval $cmd
