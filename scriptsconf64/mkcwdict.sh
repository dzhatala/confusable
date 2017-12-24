datadir=`cat datadir.txt`
echo Making continous dict ...:datadir=$datadir 
sdir=hmm16
tdir=clhmm
sphones=triphones2
tphones=cwtriphones
sdict=$datadir/words.dic
tgtdict=cw2.dic

sort "$sdict" > words-sort.dic

cat words-sort.dic | gawk '
function tri2mono (tri)
{

	#print tri
	iright= index (tri,"+");
	ileft= index (tri, "-");
	
	trimmed=tri
	if (ileft > 0)
		trimmed = substr(tri,ileft+1,length(tri));
	end
	
	iright= index (trimmed,"+");
	l1=length(trimmed);
	if (iright > 0)
		trimmed = substr(trimmed,1,iright-1);
	end
	 
	#print tri " <==> " trimmed
	return trimmed
	#print $1,	$2,	trimmed
	
	
}


{
	
	if(index($0,"VK_A")>0)next 
	if(index($0,"VK_I")>0)next 
	if(index($0,"VK_U")>0)next 
	if(index($0,"VK_E")>0)next 
	if(index($0,"VK_O")>0)next 
	if(index($0,"ACTION_ON_OFF")>0)next 
	if(index($0,"TEST_123")>0)next 
	
	phoneNums=split($0,outar," ")
	smono=tri2mono(outar[2])
	lastmono=tri2mono(outar[phoneNums])
	#print $1 " numphones=" phoneNums " start=" outar[2] " =>"  smono " latest=" outar[phoneNums] " =>" lastmono
	
	newentry=outar[1] "\t"
	newentry2=outar[1] "\t\t\t"
	for (i=2; i <=phoneNums ; i++){
		phone=""
		ignore=0
		if(i>=2){
			if(index(outar[i],"sil")>0 ) {
				phone=outar[i]
				ignore=1
			}
			if(index(outar[i],"sp")>0 ) {
				phone=outar[i]
				ignore=1
			}
			if(index(outar[i],"#N")>0 ) {
				phone=outar[i]
				ignore=1
			}
			if(index(outar[i],"-uw+")>0 ) {
				phone=outar[i]
				ignore=1
			}
			
			#further check
			
		}
		
		phone2=outar[i]
		if(ignore!=1){
			if(i==2) {
				phone="center_" smono
				
			}else if (i==phoneNums){
				phone="center_" lastmono

				if(index(phone,"center_a")>0){
					phone=phone " center_h"
				}
				if(index(phone,"center_i")>0){
					phone=phone " center_h"
				}
				if(index(phone,"center_u")>0){
					phone=phone " center_h"
				}
				if(index(phone,"center_e")>0){
					phone=phone " center_h"
				}
				if(index(phone,"center_o")>0){
					phone=phone " center_h"
				}
				
			}else {
				phone=outar[i]
				
			}
			
			phone2="center_" tri2mono(outar[i])
			
		}
		newentry=newentry " " phone
		newentry2=newentry2 " " phone2		
	}
	
	print newentry
	print newentry2
}' > "$tgtdict"


cmd="../htk/HTKTools/HDMan -g cw.ded -m cwnow.dicts words-sort.dic cw2.dic"
echo $cmd ; eval $cmd
