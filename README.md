<a href="https://hub.docker.com/repository/docker/grosa1/minecraft-forge-server">
        <img src="https://img.shields.io/docker/pulls/grosa1/minecraft-forge-server.svg?style=flat-square&color=brightgreen&logo=docker&logoColor=white"
            alt="Pulls"></a> 

# minecraft-forge-server

Simple Dockerfile to deploy Minecraft Forge server MC 1.12.2

## Usage
```
docker build . -t minecraft_rlc && docker run -d -p 25565:25565 minecraft_rlc
```
