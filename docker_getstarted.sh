# Switch to Linux containers
aws ecr get-login-password
docker login -u AWS https://881299141635.dkr.ecr.us-west-2.amazonaws.com
docker pull 881299141635.dkr.ecr.us-west-2.amazonaws.com/devoracle:latest
docker volume create oradata
docker volume create oradbs

docker ps -a

docker start devoracle

# 0. 
## 0.1. Get all possible docker commands
docker
## 0.2. Get docker info
docker info

# 1. Docker Images
## 1.1. List images
docker images
## 1.2. List all dangling images
docker images -f dangling=true
## 1.10. remove docker images
docker rmi {image-ID}
## 1.11. remove all dangling images
docker images prune [-{flag}]
docker images prune -a # remove all images not referenced by any container.

# 2. Docker container
# 2.1. Run a container by using name + tag (version)
docker run [{flag}]{container-image-name}[:{tag}][{command to run in container}]
docker run -ti ubuntu:latest bash # -ti for Terminal Interactive, bash command to run in ubuntu
docker run -ti ubuntu:latest
docker run -ti ubuntu             # latest is the default tag
## root@ae280b3ddcf2:/# cat /etc/lsb-release
## DISTRIB_ID=Ubuntu
## DISTRIB_RELEASE=20.04
## DISTRIB_CODENAME=focal
## DISTRIB_DESCRIPTION="Ubuntu 20.04.1 LTS"
## exit (or CTL d)
# 2.2. Run a container by using image ID
docker run -ti bf756fb1ae65 bash
# 2.10. Running containers
docker ps   # with default formatting (horizontal)
docker ps --format "\nID\t{{.ID}}\nIMAGE\t{{.Image}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.RunningFor}}\nSTATUS\t{{.Status}}\nPORTS\t{{.Ports}}\nNAMES\t{{.Names}}\n"
docker ps -a # to see all container, even those that are stopped
docker ps -l # to see the most recently exited container
## Check STATUS exited code to get a clue why container stopped:
Status 0   : succes
Status 127 :
Status 130 :
## Check PORT for networking
# 2.20. remove a container
docker rm {container-ID}
# 2.21. remove all containers
docker rm $(docker ps -a -q)

# 3. Create an docker image out of an docker container
# 3.1. Commit + Tag commands
docker commit {container-ID} ## Get an image ID as a sha256
docker tag {image-ID-sha256} {image-name}
docker images # to find the new image
# 3.2. Commit with container name
docker commit {container-name} {image-name}
docker images # to find the new image







