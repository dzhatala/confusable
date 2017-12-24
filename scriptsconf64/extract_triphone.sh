
mkdir -p ../../datas/triphones_found
#./extract_triphone.awk ../../datas/test.txt > ../../datas/monop.lab
./extract_triphone.awk ../../datas/3000indonesiamwords.txt > ../../datas/monop.lab
../htk/HTKTools/HLEd -T 3 -l ../../datas/triphones_found -n ../../datas/triphones_found/alltriphones   extract.led ../../datas/monop.lab
sort ../../datas/triphones_found/alltriphones | uniq > ../../datas/triphones_found/alltriphones_sort_uniq.txt
