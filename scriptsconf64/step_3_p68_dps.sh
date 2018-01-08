source env.sh
S_SCP=train.scp
N_SCP=train.scp
#mlf_aligned="-l LABEL -I train.tri.aligned.mlf"
mlf_aligned="-l LABEL -I noalign.mlf"
#mlf_aligned="-l LABEL -I mono.manual.mlf"
cmd="$HTKTOOLS_DIR/HNTrainSGD -C config.basic -C config.pretrain -H dnn3/init/macros -H dnn3/init/hmmdefs -M dnn3 "
cmd="$cmd -S $S_SCP -N  $N_SCP  	$mlf_aligned"
cmd="$cmd monophones1	"
echo $cmd ;eval $cmd

