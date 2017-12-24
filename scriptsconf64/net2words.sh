if [ "$1" == "" ]; then
	FAILED="asfsdfsf"
	echo usage: net2words.sh htk_wdnet_files
fi

if [ "$FAILED" == "" ]; then
	 #for x in `cat $1 | grep "W=" | cut -f 4 -d " "   | sort -r | grep "=" |  sed s/W=// |  sed s/!NULL// | sort -r | uniq `
	 #do
		#echo $x
	 #done
	 
	 cat $1 | awk  '{
		
		if(index($2,"W=")>0){
			
			#print $2
			w=substr($2,3,length($2))
			if(index(w,"!NULL")<=0)
			print w
		}
	 }
	 '
fi


