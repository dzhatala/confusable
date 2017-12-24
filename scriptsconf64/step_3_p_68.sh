source env.sh
mkdir -p cvn/mfc
cmd="$HTKTOOLS_DIR/HCompV -p *%%% -k *.%%% -C cvn.cfg -q v -c cvn -S train.scp"
echo $cmd ; eval $cmd

