image_version=`date +%Y%m%d%H%M`;
echo $image_version;
# cd JenkinsDocker
git pull --rebase origin master;
docker stop JenkinsDocker;
docker rm JenkinsDocker;
docker build -t JenkinsDocker:$image_version .;
docker images;
docker run -p 10001:80 -d --name JenkinsDocker JenkinsDocker:$image_version;
# -v ~/docker-data/house-web/appsettings.json:/app/appsettings.json -v ~/docker-data/house-web/NLogFile/:/app/NLogFile   --restart=always
docker logs JenkinsDocker;
#删除build过程中产生的镜像    #docker image prune -a -f
docker rmi $(docker images -f "dangling=true" -q)