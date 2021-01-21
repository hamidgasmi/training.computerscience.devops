# Switch to Linux containers
aws ecr get-login-password
docker login -u AWS https://881299141635.dkr.ecr.us-west-2.amazonaws.com
docker pull 881299141635.dkr.ecr.us-west-2.amazonaws.com/devoracle:latest
docker volume create oradata
docker volume create oradbs

docker ps -a

docker start devoracle

# 1. 
# 2. Run a docker
docker run [container-image-name]
docker run hello-world
