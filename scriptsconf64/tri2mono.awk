#!/bin/awk -f 

#usage tri2mono.awk triphones1 

{

	#print $3
	iright= index ($3,"+");
	ileft= index ($3, "-");
	
	trimmed=$3
	if (ileft > 0)
		trimmed = substr($3,ileft+1,length($3));
	end
	
	iright= index (trimmed,"+");
	l1=length(trimmed);
	if (iright > 0)
		trimmed = substr(trimmed,1,iright-1);
	end
	
	#print $3 " <==> " trimmed
	if(index($3,"sp")>0){
		trimmed="sil"
	}
	print $1,	$2,	trimmed
	
}
