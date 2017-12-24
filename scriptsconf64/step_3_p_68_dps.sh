source env.sh
S_SCP=train.scp
N_SCP=train.scp
cmd="$HTKTOOLS_DIR/HNTrainSGD -C config.basic -C config.pretrain -H dnn3/init/macros -H dnn3/init/hmmdefs -M dnn3 "
cmd="$cmd -S $S_SCP -N  $N_SCP -l LABEL 	-I train.tri.aligned.mlf"
cmd="$cmd monophones1	"
echo $cmd ;eval $cmd

