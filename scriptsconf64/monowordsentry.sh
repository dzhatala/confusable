
echo $1 | gawk '{

	#print $1
	len=length($1)
	entry=""
	for (i=1 ; i<=len ; i++){
			entry=entry " center_"  tolower(substr($1,i,1))
	}
	print $1 "		" entry
	

}'
