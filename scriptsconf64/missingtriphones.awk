#!/bin/awk -f 

#usage missingtriphones lesser_list complete_list
BEGIN {
	fileTouch=0
	hashTable=""
	lesser=""
}	
{

	#print FNR " " FILENAME " " 
	if(FNR==1) {
		fileTouch++;
		lesser=FILENAME;
	}
	
	if(fileTouch==1){
		hashTable=hashTable "_" $1
	}
	#print  hashTable
	if(fileTouch>1){
		needle = "_" $1
		
		if(index(hashTable,needle)<=0){
			print $0
		} else {
			#print $1 " exist in " lesser
		}
	}
	
	
	
}
