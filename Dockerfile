FROM httpd:2.4.29

MAINTAINER Sinan Goo 

RUN apt-get update \
  && apt-get install -y --no-install-recommends openssl \
  && rm -r /var/lib/apt/lists/*

# RUN echo "" >> /usr/local/apache2/conf/httpd.conf
# RUN echo "Include /etc/apache2/mods-available/jk.load" >> /usr/local/apache2/conf/httpd.conf
# RUN echo "Include /etc/apache2/mods-available/jk.conf" >> /usr/local/apache2/conf/httpd.conf

# RUN sed -i s/#LoadModule ssl_module modules/mod_ssl.so/LoadModule ssl_module modules/mod_ssl.so/g /usr/local/apache2/conf/httpd.conf; httpd-foreground"


EXPOSE 443

RUN sed -i 's%#\(Include conf/extra/httpd-ssl.conf\)%\1%' /usr/local/apache2/conf/httpd.conf \
  && sed -i 's%#\(LoadModule ssl_module modules/mod_ssl.so\)%\1%' /usr/local/apache2/conf/httpd.conf \
  && sed -i 's%#\(LoadModule socache_shmcb_module modules/mod_socache_shmcb.so\)%\1%' c/usr/local/apache2/onf/httpd.conf
  # \
  # && sed -i 's%ServerName www.example.com:443%ServerName ${SERVER_NAME}:443%' /usr/local/apache2/conf/extra/httpd-ssl.conf

# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /usr/local/apache2/conf/server.key -out /usr/local/apache2/conf/server.crt
RUN openssl req -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com" -x509 -nodes -days 365 -newkey rsa:2048 -keyout /usr/local/apache2/conf/server.key -out /usr/local/apache2/conf/server.crt

# RUN mkdir -p /var/log/apache2

