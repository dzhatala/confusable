echo "###############open_app.sh called#########################" 
cmd=`cat APP_LIST.TXT | grep "$1" | cut -f 2 -d " "`

if [ "$cmd" != "" ]; then
	echo "###############executing $cmd#########################" 
	eval $cmd
else
	echo "###############can't found $1#########################"
fi
 