# docker-tomcat8-jdk

## To build the image:
```
cd docker-tomcat8-jdk
docker build -t jdk8-tomcat-python:centos .
```

## To run the image [Place you war file in /webapp folder]:
```
mkdir /webapp
mkdir /logs
docker run -d -v /webapp:/tomcat/webapps -v /logs:/tomcat/logs -p 8080:8080 jdk8-tomcat:centos7
```
