 hvite="../htk/HTKTools/HVite "
 dir="hmm12"
 phones=triphones1
 dict=words.dic
 net=words.net
 cmd="$hvite -o S -T 1   -C config_hvite_wav-mito.txt -S word-mito.scp -H $dir/macros -H " 
 cmd="$cmd $dir/hmmdefs -w $net $dict $phones "
 echo $cmd ; eval $cmd
 