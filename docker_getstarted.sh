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
# 2.0. Create and Start a docker
docker create {container-image-name}
docker start [-a] {container-ID} # -a flag to let the docker diplays its output in the cli.
# docker start could be used to restart a container that is stopped but we can not override its default startup command then.
# to use docker log to see docker output if container is start without -a flag
# 2.1. Run a container by using name + tag (version) + override command (this command override the image startup command)
# ... docker run = docker create + docker start
docker run [{flag}]{container-image-name}[:{tag}][{override command}]
docker run -it ubuntu:latest bash # -it = -i -t. -i to attach process STDIN channel to the CLI; -t to format output (to remember Interactive Terminal)
docker run -it ubuntu:latest
docker run -it ubuntu             # latest is the default tag
## root@ae280b3ddcf2:/# cat /etc/lsb-release
## DISTRIB_ID=Ubuntu
## DISTRIB_RELEASE=20.04
## DISTRIB_CODENAME=focal
## DISTRIB_DESCRIPTION="Ubuntu 20.04.1 LTS"
## exit (or CTL d)
# 2.2. ... by using image ID
docker run -it {image-ID} bash
docker run -it bf756fb1ae65 bash
# 2.3. ... + give the container a name
docker run --name hamid-container -it ubuntu bash
# 2.3. ... + add command
docker run -it ubuntu bash -c "sleep 3; echo all done"
# 2.4. ... for N seconds
docker run -it ubuntu bash -c "sleep 3; echo all done" sleep 5
# 2.5. ... + delete a container when it exits
docker run --rm -it ubuntu bash -c "sleep 3; echo all done" sleep 5
# 2.5. ... detached
docker run -d -it ubuntu bash
# 2.10. Resource Constraints:
# 2.11. Memory Limits
docker run --memory maximum-allowed-memory {image-name} {command}
# 2.12. CPU Limits:
docker run --cpu-shares {relative to other containers} {image-name} {command} # Relative limit
docker run --cpu-quota {hard limit} # Hard limit
# 2.20 Networking: -p: Publish a port
docker run -p outside-port-to-publish:inside-port-to-listen-to/protocol #(tcp/udp)
# ... exposing/publishing 2 ports:
docker run --rm -it -p 45678:45678 -p 45679:45679 --name echo-server ubuntu:14.04 bash
nc -lp 45678 | nc -lp 45679
# ... In a 2nd terminal:
docker run --rm -it ubuntu:14.04 bash
> nc host.docker.internal 45678
# ... In a 3rd terminal:
docker run --rm -it ubuntu:14.04 bash
> nc host.docker.internal 45679
# ... from the 2nd terminal
Test message
# ... In the 3rd terminal
Test message
# ... 2nd ncat -> 1st. ncat -> 3rd. ncat
# 2.21 Networking: -p: Publish ports dynamically
docker run --rm -it -p 45678 -p 45679 --name echo-server ubuntu:14.04 bash
nc -lp 45678 | nc -lp 45679
# ... in another terminal:
docker port echo-server
45678/tcp -> 0.0.0.0:49154
45679/tcp -> 0.0.0.0:49274
# ... In a 2nd terminal:
docker run --rm -it ubuntu:14.04 bash
> nc host.docker.internal 49154 # outside port
# ... In a 3nd terminal:
docker run --rm -it ubuntu:14.04 bash
> nc host.docker.internal 49274 # outside port
# 2.20 Networking: -p: UDP port
docker run --rm -it -p 45678/udp --name echo-server ubuntu:14.04 bash
> nc -ulp 45678
# ... in another terminal:
docker port echo-server
45678/tcp -> 0.0.0.0:49154
# ... In a 2nd terminal:
docker run --rm -it ubuntu:14.04 bash
> nc -u host.docker.internal 49154 # outside port -u for udp

# 3. Exec a new process inside a container: let have a multiple commands container
docker exec [-flags] {container-name} sh # sh flags let's us run commands inside the container without the need to docker exec
docker exec -it happy_kare bash
# 3.1. Example: create a container with that has 2 processes: redis and redis-cli
docker run redis
docker exec -it {redis-container-id} redis-cli
# 3.2. Example: create a container with that has 2 processes: redis and redis-cli
docker run -it redis sh
# redis-cli (inside the container)

# 4. Stop a container
docker stop {container-ID}
docker kill {container-ID}
docker kill {container-name}

# 5. Restart a container
docker start {container-Id} # We can not override its default startup command.

# 6. Logs
docker logs {container-ID}
docker logs {container-name}
# docker start -a container-id = docker start container-id + docker logs container-id

# 7. docker ps: Running containers
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

# 8. Create an docker image out of an docker container
# 8.1. Commit + Tag commands
docker commit {container-ID} ## Get an image ID as a sha256
docker tag {image-ID-sha256} {image-name}
docker images # to find the new image
# 8.2. Commit with container name
docker commit {container-name} {image-name}
docker images # to find the new image


# 9. remove a container
docker rm {container-ID}
docker rm {container-name}
# ... remove all containers
docker rm $(docker ps -a -q)

# 10. Cleanup all containers. The command below will remove:
# ... All stopped containers
# ... All networks not used by at least one container
# ... All dangling images
# ... All build cache
docker system prune
