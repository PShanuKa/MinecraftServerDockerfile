FROM eclipse-temurin:17-jdk-jammy

WORKDIR /minecraft

# ENV variables (default values)
ENV RAM_MAX=2G
ENV RAM_MIN=2G
ENV ONLINE_MODE=true
ENV MAX_PLAYERS=20
ENV MOTD="My Minecraft Server"

# Server jar download
ADD https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/196/downloads/paper-1.20.1-196.jar server.jar

# Accept EULA
RUN echo "eula=true" > eula.txt

# First run එකේ properties generate වෙන්න script එකක්
RUN echo '#!/bin/bash \n\
java -Xmx${RAM_MAX} -Xms${RAM_MIN} -jar server.jar nogui & \n\
PID=$! \n\
sleep 10 \n\
kill $PID \n\
sleep 5 \n\
sed -i "s/online-mode=true/online-mode=${ONLINE_MODE}/" server.properties \n\
sed -i "s/max-players=.*/max-players=${MAX_PLAYERS}/" server.properties \n\
sed -i "s/motd=.*/motd=${MOTD}/" server.properties \n\
java -Xmx${RAM_MAX} -Xms${RAM_MIN} -jar server.jar nogui' > start.sh

RUN chmod +x start.sh

EXPOSE 25565

CMD ["bash", "start.sh"]
