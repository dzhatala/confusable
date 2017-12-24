source env.sh
MMF="-H hmm7/macros -H hmm7/hmmdefs"
cmd="$HTKTOOLS_DIR/HVite -C config.align $MMF -S train.scp  "
cmd="$cmd -i train.mono.aligned.mlf -f -o MW -b sil -a -y lab phone1.dic monophones1"
echo $cmd;  eval $cmd

