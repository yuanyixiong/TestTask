echo "=================设置jenkins参数================="
echo "设置不杀shell启动的进程"
BUILD_ID=dontKillMe


echo "=================初始化目录================="
app=/usr/local/src/app
config=/usr/local/src/config
files=/usr/local/src/files
service=/usr/local/src/app/service
flume_root=$app/apache-flume-1.6.0-bin
sleep 1s


service_name=TestTask
copy_jar=/TestTask-1.0-SNAPSHOT.jar


mkdir -p $service/$service_name
echo "1" >> $service/$service_name/$service_name.pid

echo "=================kill application service================="
kill -9 `cat $service/$service_name/$service_name.pid`
sleep 5s
rm -rf $service/$service_name

echo "=================start application service================="
mkdir -p $service/$service_name
cp /root/.jenkins/workspace/$service_name/target/$copy_jar $service/$service_name

java -jar -Xmx128m -Xms64m -Xmn32m -Xss16m $service/$service_name/$copy_jar --server.port=8888 >> $service/$service_name/$service_name.log & echo $! > $service/$service_name/$service_name.pid

echo "=================unzip flume config================="
unzip -j $service/$service_name/$copy_jar "*/flume.*" -d $service/$service_name/flume

echo "=================kill flume service================="
echo "1" >> $service/$service_name/flume/flume.pid
kill -9 `cat $service/$service_name/flume/flume.pid`
sleep 5s
rm -rf $service/$service_name/flume/flume.pid
rm -rf $service/$service_name/flume/flume.log
sleep 1s

echo "=================start flume service================="
$flume_root/bin/flume-ng agent -n a1 -c conf -f $service/$service_name/flume/flume.conf -Dflume.root.logger=INFO,console > $service/$service_name/flume/flume.log & echo $! > $service/$service_name/flume/flume.pid &