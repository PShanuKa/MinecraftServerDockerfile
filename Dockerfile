# Java version එක තෝරාගන්න (Minecraft version එක අනුව මෙය වෙනස් වේ)
FROM eclipse-temurin:17-jdk-jammy

# සර්වර් එකට අවශ්‍ය folder එක හදන්න
WORKDIR /minecraft

ENV ENV ONLINE_MODE=false

# Minecraft Server jar එක download කරන්න (උදාහරණයක් ලෙස PaperMC)
ADD https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/196/downloads/paper-1.20.1-196.jar server.jar

# EULA එකට එකඟ වෙන්න (මෙය සර්වර් එක run වීමට අත්‍යවශ්‍යයි)
RUN echo "eula=true" > eula.txt

# Port එක විවෘත කරන්න
EXPOSE 25565

# සර්වර් එක run කරන command එක
CMD ["java", "-Xmx2G", "-Xms2G", "-jar", "server.jar", "nogui"]
