source env.sh
mkdir -p dnn7.finetune/init
MMF="-H dnn3/macros -H dnn3/hmmdefs"
mlf_aligned="-l LABEL -I noalign.mlf"
cmd="$HTKTOOLS_DIR/HNTrainSGD -C config.basic -C config.finetune $MMF "
cmd="$cmd -M dnn7.finetune -S train.scp   "
cmd="$cmd $mlf_aligned monophones1"
echo $cmd ; eval $cmd
