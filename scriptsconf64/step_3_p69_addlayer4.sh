source env.sh
mkdir -p dnn4/init
MMF="-H dnn3/macros -H dnn3/hmmdefs"
cmd="$HTKTOOLS_DIR/HHEd $MMF -M dnn4/init addlayer4.hed monophones1"
echo $cmd ; eval $cmd

