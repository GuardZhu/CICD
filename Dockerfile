#FROM openjdk:8-jdk-alpine
#EXPOSE 8060
#ARG JAR_FILE
#ADD ${JAR_FILE} /app.jar
#ENTRYPOINT ["java", "-jar","/app.jar"]
## ${JAR_FILE} 这个参数是从pox.xml 文件中传过来的，名称必须一致才行。
#

#FROM openjdk
FROM openjdk:8-jdk-alpine
ARG JAR_FILE
COPY ${JAR_FILE} app.jar
# 注意每个项目公开的端口不一样
EXPOSE 9000
ENTRYPOINT ["java","-jar","/app.jar"]