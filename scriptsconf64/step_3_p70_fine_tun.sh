source env.sh
mkdir -p dnn7.finetune/init
MMF="-H dnn3/macros -H dnn3/hmmdefs"
cmd="$HTKTOOLS_DIR/HNTrainSGD -C config.basic -C config.finetune $MMF "
cmd="$cmd -M dnn7.finetune -S train.scp  -l LABEL "
cmd="$cmd -I train.mono.aligned.mlf monophones1"
echo $cmd ; eval $cmd
