#!/bin/awk -f 

#usage hviteMinOS_2sfs.awk x.alg.wrds
BEGIN {
 ts=-1.0
}
{

	#print length($4)
	if(length($4)>0){
		if(ts<0){
			ts=($1+0);
			w=$4;
			#print "ts " ts
		}else {
			print ts " " $1 " " w
			ts=$1+0;
			w=$4
		}
	}
	
}
END{
	print ts " " $2 " " w
}
