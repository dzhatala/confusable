#!/bin/awk -f 

#usage rmvarhmm.awk hmf_file 
BEGIN {
	begin=0
}
{
	if(begin==0)
		begin=index ($1,"~h");
	if(begin>0)
		print $0
	
}
