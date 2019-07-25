FROM centos:latest
RUN yum install -y java-1.8.0-openjdk
RUN yum install -y java-1.8.0-openjdk-devel
RUN java -version
RUN echo "Installing Tomcat"
ENV APACHE_TOMCAT_DOWNLOAD_URL http://us.mirrors.quenda.co/apache/tomcat/tomcat-8/v8.5.43/bin/apache-tomcat-8.5.43.tar.gz
ENV APACHE_TOMCAT_INSTALL_DIR /usr/local/apache-tomcat-8.5.43

COPY apache-tomcat-8.5.43.tar.gz /apache-tomcat-8.5.43.tar.gz
RUN  pwd
RUN  tar -xzf apache-tomcat-8.5.43.tar.gz 
RUN  mv apache-tomcat-8.5.43 /usr/local/ 

# Modify default config to use well-known paths

RUN cat ${APACHE_TOMCAT_INSTALL_DIR}/conf/server.xml | \
	sed 's/appBase="webapps"/appBase="\/tomcat\/webapps"/' | \
	sed 's/directory="logs"/directory="\/tomcat\/logs"/' > \
	/tmp/server.xml

RUN cp /tmp/server.xml ${APACHE_TOMCAT_INSTALL_DIR}/conf/server.xml
RUN rm /tmp/server.xml

RUN mkdir -p /tomcat/webapps/
RUN mkdir -p /tomcat/logs/

COPY entrypoint.sh /
RUN chmod +777 /entrypoint.sh

RUN echo 'Installing Python'
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install python36 -y
RUN python3 --version

EXPOSE 8080 8009
VOLUME ["/tomcat/webapps", "/tomcat/logs"]
CMD ["/entrypoint.sh"]
