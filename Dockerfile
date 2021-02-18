FROM openjdk:8u212-jre-alpine

# upgrade all packages since alpine jre8 base image tops out at 8u212
RUN apk -U --no-cache upgrade

RUN apk add --no-cache -U \
  openssl \
  imagemagick \
  lsof \
  su-exec \
  shadow \
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

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 777 /data \
  && chown minecraft:minecraft /data /home/minecraft

WORKDIR /home/minecraft
RUN wget https://media.forgecdn.net/files/2935/323/RLCraft+Server+Pack+1.12.2+-+Beta+v2.8.2.zip \
  && unzip RLCraft+Server+Pack+1.12.2+-+Beta+v2.8.2.zip \
  && wget https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2838/forge-1.12.2-14.23.5.2838-installer.jar

RUN java -jar forge-1.12.2-14.23.5.2838-installer.jar --installServer \
  && echo "eula=true" > eula.txt

EXPOSE 25565

CMD java -Xms1G -Xmx3G -jar forge-1.12.2-14.23.5.2838-universal.jar
