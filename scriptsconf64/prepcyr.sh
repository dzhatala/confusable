dir=hmm14
out=cyr
cmd="cp $dir/hmmdefs $dir/macros $out/"
echo $cmd; eval $cmd;

cmd="cp triphones1 $out/tiedlist"
echo $cmd; eval $cmd;

cmd="cp words.net $out/wdnet_treq"
echo $cmd; eval $cmd;


cmd="cp words.dic $out/dict_treq_word"
echo $cmd; eval $cmd;
