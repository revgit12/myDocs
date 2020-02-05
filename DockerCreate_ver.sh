#!/bin/sh

set -x
docker_base=$WORKSPACE/Docker_base
dkr_rel=$WORKSPACE/uivdocker
tmp_path=$WORKSPACE/rpmtemp
checkoutpath=$WORKSPACE/framework
dockerfiles=$checkoutpath/uiv-installer/Docker_files
ver_no=$1
dkr_rel=$WORKSPACE/uivdockers

mkdir -p $docker_base
mkdir -p $dkr_rel
mkdir -p $tmp_path



copy_check()
{
if [ "$?" != "0" ]; then
    echo "[Error] copy failed!" 1>&2
    exit 1
fi
}

find_copy_jar()
{
	src_dir=$1
	dest_dir=$2
	
	find $src_dir/target -name "*.jar" -print 2>/dev/null |
	while read line
	do
		fname=`basename $line` 
		if [ ! -f $dest_dir/$fname ];
		then
		  cp -rvf $line $dest_dir
		  copy_check
		fi
	done
	
}


dkr_uivkf()
{
	dkrimage=uiv-kf
	echo "checkpoint for $dkrimage docker build starts: `date` "

mkdir $docker_base/$dkrimage
cd $docker_base/$dkrimage

cp -rf $checkoutpath/uiv-installer/Kafka/docker-conf/kafka-0-8-2.yml .
copy_check
cp -rf $checkoutpath/uiv-installer/Kafka/docker-conf/* .
copy_check
cp -rf $dockerfiles/Dockerfile.uiv-kf .
copy_check
pwd
chmod -R 755 *
chmod 400 conf/jmx*
docker build -t ${dkrimage}:${ver_no} --no-cache=true -f Dockerfile.uiv-kf .

copy_check
docker save -o ${dkrimage}.tar $dkrimage:${ver_no}
cp -rf ${dkrimage}.tar $WORKSPACE
sleep 1
echo "checkpoint for dkr_uivkf docker build ends: `date` "
}

dkr_uivzk()
{
	dkrimage=uiv-zk
	echo "checkpoint for $dkrimage docker build starts: `date` "

mkdir $docker_base/$dkrimage
cd $docker_base/$dkrimage

cp -rf $checkoutpath/uiv-installer/zookeeper/* .
copy_check
cp -rf $dockerfiles/Dockerfile.uiv-zk .
copy_check
cp -rf $checkoutpath/uiv-installer/Kafka/create_topics.sh .
copy_check
cp -rf $checkoutpath/uiv-installer/Kafka/topic_data_uiv.txt .
copy_check
pwd
chmod -R 755 *
docker build -t ${dkrimage}:${ver_no} --no-cache=true -f Dockerfile.uiv-zk .

copy_check
docker save -o ${dkrimage}.tar $dkrimage:${ver_no}
cp -rf ${dkrimage}.tar $WORKSPACE
sleep 1
echo "checkpoint for dkr_uivzk docker build ends: `date` "
}

dkr_uivcmdb()
{
	dkrimage=uiv-cmdb
	echo "checkpoint for $dkrimage docker build starts: `date` "

mkdir $docker_base/$dkrimage
cd $docker_base/$dkrimage

cp -rf $checkoutpath/uiv-db/MySQL/* .
copy_check
cp -rf $checkoutpath/uiv-installer/mariadb/* .
copy_check
cp -rf $dockerfiles/Dockerfile.uiv-cmdb .
copy_check
pwd
docker build -t ${dkrimage}:${ver_no} --no-cache=true -f Dockerfile.uiv-cmdb .

copy_check
docker save -o ${dkrimage}.tar $dkrimage:${ver_no}
cp -rf ${dkrimage}.tar $WORKSPACE
sleep 1
echo "checkpoint for dkr_uivzk docker build ends: `date` "
}

dkr_uivckey()
{
	dkrimage=uiv-ckey
	echo "checkpoint for $dkrimage docker build starts: `date` "

mkdir $docker_base/$dkrimage
cd $docker_base/$dkrimage
cp -rf $checkoutpath/uiv-installer/keycloak/standalone.xml .
copy_check
cp -rf $checkoutpath/uiv-installer/keycloak/configure_admin_cli.sh .
copy_check
cp -rf $dockerfiles/Dockerfile.uiv-ckey .
copy_check
pwd
docker build -t ${dkrimage}:${ver_no} --no-cache=true -f Dockerfile.uiv-ckey .

copy_check
docker save -o ${dkrimage}.tar $dkrimage:${ver_no}
cp -rf ${dkrimage}.tar $WORKSPACE
sleep 1
echo "checkpoint for dkr_uivzk docker build ends: `date` "
}

dkr_uivckng()
{
	dkrimage=uiv-ckng
	echo "checkpoint for $dkrimage docker build starts: `date` "

mkdir $docker_base/$dkrimage
cd $docker_base/$dkrimage

cp -rf $dockerfiles/Dockerfile.uiv-ckng .
copy_check
pwd
docker build -t ${dkrimage}:${ver_no} --no-cache=true -f Dockerfile.uiv-ckng .

copy_check
docker save -o ${dkrimage}.tar $dkrimage:${ver_no}
cp -rf ${dkrimage}.tar $WORKSPACE
sleep 1
echo "checkpoint for dkr_uivzk docker build ends: `date` "
}

dkr_uivcpro()
{
	dkrimage=uiv-cpro
	echo "checkpoint for $dkrimage docker build starts: `date` "

mkdir $docker_base/$dkrimage
cd $docker_base/$dkrimage
cp -rf $checkoutpath/uiv-installer/prometheus/prometheus.yml .
copy_check
cp -rf $checkoutpath/uiv-installer/prometheus/prometheus_init.sh .
copy_check
cp -rf $dockerfiles/Dockerfile.uiv-cpro-p .
copy_check
pwd
docker build -t ${dkrimage}:${ver_no} --no-cache=true -f Dockerfile.uiv-cpro-p .

copy_check
docker save -o ${dkrimage}.tar $dkrimage:${ver_no}
cp -rf ${dkrimage}.tar $WORKSPACE
sleep 1
echo "checkpoint for dkr_uivzk docker build ends: `date` "
}

dkr_uivgrf()
{
	dkrimage=uiv-grf
	echo "checkpoint for $dkrimage docker build starts: `date` "

mkdir $docker_base/$dkrimage
cd $docker_base/$dkrimage

cp -rf $dockerfiles/Dockerfile.uiv-cpro-g .
copy_check
cp -rf $checkoutpath/uiv-installer/grafana/* .
copy_check
pwd
docker build -t ${dkrimage}:${ver_no} --no-cache=true -f Dockerfile.uiv-cpro-g .

copy_check
docker save -o ${dkrimage}.tar $dkrimage:${ver_no}
cp -rf ${dkrimage}.tar $WORKSPACE
sleep 1
echo "checkpoint for dkr_uivzk docker build ends: `date` "
}

dkr_uivne()
{
	dkrimage=uiv-ne
	echo "checkpoint for $dkrimage docker build starts: `date` "

mkdir $docker_base/$dkrimage
cd $docker_base/$dkrimage

cp -rf $dockerfiles/Dockerfile.uiv-cpro-n .
copy_check
pwd
docker build -t ${dkrimage}:${ver_no} --no-cache=true -f Dockerfile.uiv-cpro-n .

copy_check
docker save -o ${dkrimage}.tar $dkrimage:${ver_no}
cp -rf ${dkrimage}.tar $WORKSPACE
sleep 1
echo "checkpoint for dkr_uivzk docker build ends: `date` "
}

dkr_uivam()
{
	dkrimage=uiv-am
	echo "checkpoint for $dkrimage docker build starts: `date` "

mkdir $docker_base/$dkrimage
cd $docker_base/$dkrimage

cp -rf $checkoutpath/uiv-installer/prometheus/config.yml .
copy_check
cp -rf $checkoutpath/uiv-installer/prometheus/alert.rules.yml .
copy_check
cp -rf $dockerfiles/Dockerfile.uiv-cpro-a .
copy_check
pwd
docker build -t ${dkrimage}:${ver_no} --no-cache=true -f Dockerfile.uiv-cpro-a .
copy_check
docker save -o ${dkrimage}.tar $dkrimage:${ver_no}
cp -rf ${dkrimage}.tar $WORKSPACE
sleep 1
echo "checkpoint for dkr_uivzk docker build ends: `date` "
}


echo "checkpoint for docker builds starts: `date` "

FNs=("dkr_uivkf" "dkr_uivzk" "dkr_uivcmdb" "dkr_uivckey" "dkr_uivckng" "dkr_uivcpro" "dkr_uivgrf" "dkr_uivne" "dkr_uivam")

for i in "${FNs[@]}"  
do  
    $i &
    sleep 15
done 


