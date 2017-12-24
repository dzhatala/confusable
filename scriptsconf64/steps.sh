yes | ./createLabs.sh ; yes | ./preparemfc.sh ; yes | ./makehmm.sh ; yes | ./maketriph.sh 


ping localhost > /dev/null ; sync
./incmix2.sh
