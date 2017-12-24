source env.sh
mkdir -p dnn3
cp /dev/null protonn/foolist
cp protonn/work/NMF protonn/dnn
mkdir -p dnn3/init			#preparing output dir
cmd="$HTKTOOLS_DIR/HHEd -H hmm7/macros -H hmm7/hmmdefs  -M dnn3/init connect.hed monophones1"
echo $cmd ;eval $cmd ;
