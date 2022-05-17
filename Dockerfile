FROM openjdk:8u212-jre-alpine 

LABEL maintainer=TüT

ENV RLCRAFT_SERVER_PACK_LINK https://media.forgecdn.net/files/3655/676/RLCraft+Server+Pack+1.12.2+-+Release+v2.9.1c.zip
ENV FORGE_LINK https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2860/forge-1.12.2-14.23.5.2860-installer.jar

# install dependencies
RUN apk -U --no-cache upgrade && \
  apk add --no-cache -U \
  openssl \
  lsof \
  su-exec \
  bash \
  curl iputils wget \
  git \
  jq \
  mysql-client \
  tzdata \
  rsync \
  nano \
  sudo \
  knock \
  ttf-dejavu 

# setup non root user
RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 777 /data \
  && chown minecraft:minecraft /data /home/minecraft

WORKDIR /home/minecraft

# install minecraft rlcraft
RUN curl ${RLCRAFT_SERVER_PACK_LINK} --output rlcraft_server.zip  && \
  unzip rlcraft_server.zip && \
  rm -f rlcraft_server.zip

# install minecraft forge server
RUN curl ${FORGE_LINK} >> forge.jar && \
  java -jar forge.jar --installServer && \
  rm -f forge.jar && \
  echo "eula=true" > eula.txt

EXPOSE 25565

CMD java -Xms1G -Xmx3G -jar forge-1.12.2-14.23.5.2860.jar