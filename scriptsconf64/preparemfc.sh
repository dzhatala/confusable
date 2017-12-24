datadir=`cat datadir.txt`
source env.sh
echo "using datadir=$datadir [ENTER]"; read
rm -f $datadir/*.mfc
cmd="$HTKTOOLS_DIR/HCopy -T 7 -C configcopy.txt -S codetr.scp"
echo $cmd ; eval $cmd
