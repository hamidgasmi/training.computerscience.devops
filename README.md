# Devops

## Table of Contents
- [Git](#git)
- [Docker](#docker)
- [Kubernetes](#kubernetes)
- [References](#references)

## Git:

<details>
<summary>Description</summary>

- For more details:
    - [Oh Shit, Git!?!](https://ohshitgit.com/)

</details>

## Docker

<details>
<summary>Description</summary>

- Docker is an engine that runs containers.
- A container is a sealed, self-contained unit of software that have everything needed to run a service.
- Containers make deployment easy:
    - Deploying is as simple as running a new container, routing users to the new one, and trashing the old one. 
    - It can even be automated by **orchestration** tools.
- A **Docker image** 
    - It contains everything it needs to run, independent of the Linux server on which it lives: a copy of the OS, a database, code, configuration files, dependencies, etc.
    - It can be packaged and shared with other Docker admin
- A **Dangling image**
    - It's layers that have no relationship to any tagged images. 
    - It no longer serves a purpose and consumes disk space.
- **Docker Hub**:
- Docker Flow: image --> Running Container --> Stopped container --> new image
- Requirements:
    - Docker needs a Linux server
    - In the same server, 2 different containers could run two different OS
    - E.g., A server is running two containers, the 1st. one can be based on RedHat Linux and he 2nd. one can run any operating system.
- Shortcuts:
    - Exit:
    - 
- For more details:

</details>

<details>
<summary>Docker commands + shortcut</summary>

- docker run: 
    - The Container has a main process
    - The container stops when the main process stops
    - The container is not done until the main process exits, even if the the container has other processes
    - The container has a name. 
    - Docker will make a name up if it isnot included in the command
    - Exit: `CTL d` or `exit`
    - Resource Constraints:
        - Memory limits: docker run --memory maximum-allowed-memory {image-name} {command}
- docker attach:
    - Detach and keep a docker running: `ctl+p ctl+q`
- docker exec:
    - Starts another process in an existing container
    - Great for debugging and DB administration
    - Can't add ports, volumes, etc.
- docker logs:
    - To look at container Output
    - Good particularly when a container stopped
    - Logs are available as long as their container is also available
    - Don't let the output get too large: it could slow down Docker to the point where our whole system becomes unresponsive
- docker kill
- docker rm

</details>

<details>
<summary>Anti-pattern and Best practices</summary>

- Don't let our containers fetch dependencies when they start:
    - Dependencies may be unavailable when container starts.
    - Include all dependencies in the container image.
    - E.g. An docker image requires node.js libraries but it doesn't include them:
        - When a container is created from this image, it fetches all node.js libraries that it needs
        - Some day, a library could be removed from node.js repo, all our containers just stops
- Don't leave important things in unnamed stopped containers:
    - You may remove them when you need to clean up stopped containers

</details>

<details>
<summary>Networking</summary>

- Programs in containers are isolated from the internet by default
- We can group our containers into private networks
- We explicitly choose who can connect to whom
- Dockers let Expose/Publish ports:
    - It makes the port accessible from outside the machine on which the docker is beeing hosted
    - It let connections in
    - It let private networks to connect between containers
    - To do it we need to specify: 
        - The **internal port** our program is listening on
        - The **external port** our container should be listening on the outside
        - The protocole to use
    - Expose ports Dynamically:
        - The port inside the container is fixed
        - The port on the host is chosen from the unused ports
        - This allows many containers running programs with fixed ports
        - This often is used with a service discovery program like Kubernetees

</details>

<details>
<summary>Orchestration</summary>

</details>

## Kubernetes

<details>
<summary>Description</summary>

- For more details:

</details>

## References

<details>
<summary>Whitepapers & Books</summary>

</details>

<details>
<summary>Talks & Courses</summary>

</details>

<details>
<summary>Articles</summary>

- [Oh Shit, Git!?!](https://ohshitgit.com/)

</details>
