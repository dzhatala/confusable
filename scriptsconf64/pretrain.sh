mkdir -p protonn/work
touch protonn/work/NMF
cmd="python GenInitDNN.py --structure \"	351X500X4\"  HTE.dnn.bn protonn/work/NMF"
echo $cmd ; eval $cmd;
#python GenInitDNN.py --quiet --structure "351X$500X4" HTE.dnn.bn protonn/work/NMF

