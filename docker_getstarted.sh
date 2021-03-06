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
# 2.2. ... by using image ID
docker run -ti {image-ID} bash
docker run -ti bf756fb1ae65 bash
# 2.3. ... + give the container a name
docker run --name hamid-container -ti ubuntu bash
# 2.3. ... + add command
docker run -ti ubuntu bash -c "sleep 3; echo all done"
# 2.4. ... for N seconds
docker run -ti ubuntu bash -c "sleep 3; echo all done" sleep 5
# 2.5. ... + delete a container when it exits
docker run --rm -ti ubuntu bash -c "sleep 3; echo all done" sleep 5
# 2.5. ... detached
docker run -d -ti ubuntu bash
# 2.10. Resource Constraints:
# 2.11. Memory Limits
docker run --memory maximum-allowed-memory {image-name} {command}
# 2.12. CPU Limits:
docker run --cpu-shares {relative to other containers} {image-name} {command} # Relative limit
docker run --cpu-quota {hard limit} # Hard limit
# 2.20 Networking: -p: Publish a port
docker run -p outside-port-to-publish:inside-port-to-listen-to/protocol #(tcp/udp)
# ... exposing/publishing 2 ports:
docker run --rm -ti -p 45678:45678 -p 45679:45679 --name echo-server ubuntu:14.04 bash
nc -lp 45678 | nc -lp 45679
# ... In a 2nd terminal:
docker run --rm -ti ubuntu:14.04 bash
> nc host.docker.internal 45678
# ... In a 3rd terminal:
docker run --rm -ti ubuntu:14.04 bash
> nc host.docker.internal 45679
# ... from the 2nd terminal
Test message
# ... In the 3rd terminal
Test message
# ... 2nd ncat -> 1st. ncat -> 3rd. ncat
# 2.21 Networking: -p: Publish ports dynamically
docker run --rm -ti -p 45678 -p 45679 --name echo-server ubuntu:14.04 bash
nc -lp 45678 | nc -lp 45679
# ... in another terminal:
docker port echo-server
45678/tcp -> 0.0.0.0:49154
45679/tcp -> 0.0.0.0:49274
# ... In a 2nd terminal:
docker run --rm -ti ubuntu:14.04 bash
> nc host.docker.internal 49154 # outside port
# ... In a 3nd terminal:
docker run --rm -ti ubuntu:14.04 bash
> nc host.docker.internal 49274 # outside port
# 2.20 Networking: -p: UDP port
docker run --rm -ti -p 45678/udp --name echo-server ubuntu:14.04 bash
> nc -ulp 45678
# ... in another terminal:
docker port echo-server
45678/tcp -> 0.0.0.0:49154
# ... In a 2nd terminal:
docker run --rm -ti ubuntu:14.04 bash
> nc -u host.docker.internal 49154 # outside port -u for udp

# 3. docker ps: Running containers
docker ps   # with default formatting (horizontal)
docker ps --format "\nID\t{{.ID}}\nIMAGE\t{{.Image}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.RunningFor}}\nSTATUS\t{{.Status}}\nPORTS\t{{.Ports}}\nNAMES\t{{.Names}}\n"
docker ps -a # to see all container, even those that are stopped
docker ps -l # to see the most recently exited container
## Check STATUS exited code to get a clue why container stopped:
Status 0   : succes
Status 127 :
Status 130 :
## Check PORT for networking
# 2.30. attach a detached container
docker attach {container-name}
#... Detach and keep a docker running: ctl+p ctl+q

# 3. Create an docker image out of an docker container
# 3.1. Commit + Tag commands
docker commit {container-ID} ## Get an image ID as a sha256
docker tag {image-ID-sha256} {image-name}
docker images # to find the new image
# 3.2. Commit with container name
docker commit {container-name} {image-name}
docker images # to find the new image

# 4. Exec new process
docker exec [-flags] {container-name}
docker exec -ti happy_kare bash

# 5. Logs
docker logs {container-ID}
docker logs {container-name}

# 6. Stop a container
docker kill {container-ID}
docker kill {container-name}

# 7. remove a container
docker rm {container-ID}
docker rm {container-name}
# ... remove all containers
docker rm $(docker ps -a -q)






