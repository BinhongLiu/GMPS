#!/bin/bash
FILE=`readlink -e $0`
rootdir=`dirname $FILE`
data_path=$rootdir/database_final

wget 'https://dryad-assetstore-merritt-west.s3.us-west-2.amazonaws.com/v3/333286/data/prophage.tar.gz?response-content-disposition=attachment%3B%20filename%3Dprophage.tar.gz&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2KERHV5E3OITXZXC%2F20241213%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20241213T201432Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=dd64d69dfe18b0583312f0f8b1d3fefd2edc422014bc357d6608e28e6584e1fa' -O $data_path/prophage.tar.gz
wget 'https://dryad-assetstore-merritt-west.s3.us-west-2.amazonaws.com/v3/333286/data/phage.tar.gz?response-content-disposition=attachment%3B%20filename%3Dphage.tar.gz&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2KERHV5E3OITXZXC%2F20241213%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20241213T201406Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=cf90e76eb5880f642f923fa45ca263f37ed245e0b49aa40bbaf177e49670d05c' -O $data_path/phage.tar.gz
wget 'https://dryad-assetstore-merritt-west.s3.us-west-2.amazonaws.com/v3/333286/data/bacteria_8.tar.gz?response-content-disposition=attachment%3B%20filename%3Dbacteria_8.tar.gz&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2KERHV5E3OITXZXC%2F20241213%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20241213T201325Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=1102ef3c5298e4e74b313fb469274faea3a3de6dbd617f0d6b0e04b63b4ed260' -O $data_path/bacteria_8.tar.gz
wget 'https://dryad-assetstore-merritt-west.s3.us-west-2.amazonaws.com/v3/333286/data/bacteria_7.tar.gz?response-content-disposition=attachment%3B%20filename%3Dbacteria_7.tar.gz&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2KERHV5E3OITXZXC%2F20241213%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20241213T201250Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=53375193a5adb50456c7d58e4f38ba4b47fd12ae9aa416daa448dccc6fada0f9' -O $data_path/bacteria_7.tar.gz
wget 'https://dryad-assetstore-merritt-west.s3.us-west-2.amazonaws.com/v3/333286/data/bacteria_6.tar.gz?response-content-disposition=attachment%3B%20filename%3Dbacteria_6.tar.gz&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2KERHV5E3OITXZXC%2F20241213%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20241213T201146Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=c6309a7e4184456d204bdd046ba9aa56ef91d480d1610b6b4ea1f9419e6463cc' -O $data_path/bacteria_6.tar.gz
wget 'https://dryad-assetstore-merritt-west.s3.us-west-2.amazonaws.com/v3/333286/data/bacteria_5.tar.gz?response-content-disposition=attachment%3B%20filename%3Dbacteria_5.tar.gz&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2KERHV5E3OITXZXC%2F20241213%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20241213T201220Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=b9eedbb82a9dc9d56b520171b4e59c739e5adeb22d0d2d734e05939c17a9c950' -O $data_path/bacteria_5.tar.gz
wget 'https://dryad-assetstore-merritt-west.s3.us-west-2.amazonaws.com/v3/333286/data/bacteria_4.tar.gz?response-content-disposition=attachment%3B%20filename%3Dbacteria_4.tar.gz&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2KERHV5E3OITXZXC%2F20241213%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20241213T201042Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=8d0eddd4ee6d54a5eb331c6f010d944e7bdcf501d4a821db7eaab7087fffd895' -O $data_path/bacteria_4.tar.gz
wget 'https://dryad-assetstore-merritt-west.s3.us-west-2.amazonaws.com/v3/333286/data/bacteria_3.tar.gz?response-content-disposition=attachment%3B%20filename%3Dbacteria_3.tar.gz&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2KERHV5E3OITXZXC%2F20241213%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20241213T200830Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=2b1ce4cbe69e08f29f79dab5a22b25556f478fb6b69be4c2953bb0498e23b258' -O $data_path/bacteria_3.tar.gz
wget 'https://dryad-assetstore-merritt-west.s3.us-west-2.amazonaws.com/v3/333286/data/bacteria_2.tar.gz?response-content-disposition=attachment%3B%20filename%3Dbacteria_2.tar.gz&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2KERHV5E3OITXZXC%2F20241213%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20241213T200827Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=64809635f9a7f772d161e9f05315fc782ba1efde3654c61e61ee47bea626e52c' -O $data_path/bacteria_2.tar.gz
wget 'https://dryad-assetstore-merritt-west.s3.us-west-2.amazonaws.com/v3/333286/data/bacteria_1.tar.gz?response-content-disposition=attachment%3B%20filename%3Dbacteria_1.tar.gz&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2KERHV5E3OITXZXC%2F20241213%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20241213T200519Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=a90bfa6a8718620d24ab794ae8cf77fac975b961c255b1600c92438e694906d8' -O $data_path/bacteria_1.tar.gz

cd $data_path

tar -xvf $data_path/phage.tar.gz
mv new_phage_tar_gz phage
cd $data_path/phage
for target in `ls *.tar.gz`;do
    tar -xvf $target
    rm $target
done

tar -xvf $data_path/prophage.tar.gz
cd $data_path/prophage
for target in `ls *.tar.gz`;do
    tar -xvf $target
    rm $target
done

rm -rf $data_path/Bacteria/Bifidobacterium_adolescentis
for m in {1..8};do
    cd $data_path
    if [ ! -s "$data_path/bacteria_$m.tar.gz" ];then
        continue
    fi
    tar -xvf $data_path/bacteria_$m.tar.gz
    for target in `ls $data_path/bacteria_$m/*.tar.gz`;do
        cd $data_path/Bacteria
	tar -xvf $target
	rm $target
    done
done
