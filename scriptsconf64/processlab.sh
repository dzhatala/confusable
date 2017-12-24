./export.sh
cat *.lab |awk '{print $NF}' | uniq | sort | uniq 	 > phonems.txt
