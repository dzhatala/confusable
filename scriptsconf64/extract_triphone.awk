#!/bin/awk -f 

#usage tri2mono.awk triphones1 

{

		print "sil"
		len=length($1)
		split($1,monops)
		x=""
		n_pushed=0.0s
		last_ltr=""
		for (i=1 ; i<=len ; i++){
			x=x substr($1,i,1) " "
			y=substr($1,i,1) " "
			
			if(n_pushed==0){
			
				if(i<len){
			
					if ( index(y,"n") >0 ){ 
						n_pushed=1.0
						last_ltr="n"
					}else if ( index(y,"-") >0 ){ 
						print "sil"
					} else 			print y
				
				} else {
					print y
				
				}
					
			} else {
					#print "hellllooo " y
						
					if ( index(y,"y") >0 ){
						print "ny"
					}else if ( index(y,"g") >0 ){
						print "ng"
					}else {
						print last_ltr
						print y
					}
					n_pushed=0.0;
					
			
			}
				
		}
		#print x
		
}
