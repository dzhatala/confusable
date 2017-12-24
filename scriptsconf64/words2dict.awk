#!/bin/awk -f 

#usage tri2mono.awk triphones1 
BEGIN {
	fileTouch=0
	hashTable=""
}	
{

	#print FNR " " FILENAME " " 
	if(FNR==1) fileTouch++;
	
	if(fileTouch==1){
		hashTable=hashTable "_" $1
	}
	#print  hashTable
	if(fileTouch>1){
		needle = "_" $1
		if(index(hashTable,needle)>0){
			print $0
		}
	}
	
	
	
}
