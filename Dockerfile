# VERSION 0.1
FROM ubuntu:12.04
MAINTAINER Olivier Dossmann, <olivier+dockerfile@dossmann.net>

# To avoid problems with Dialog and curses wizards
ENV DEBIAN_FRONTEND noninteractive

# Update list of packages
RUN apt-get update
# Install needed packages
RUN apt-get install -y python-dev python-pip sqlite3 build-essential #supervisor openssh-server vim

# Configuration
#RUN mkdir -p /var/run/sshd
#RUN echo 'root:isso' |chpasswd # change default root password

# Create directory to contains all Isso config + DB
RUN mkdir -p /opt/isso

# Install isso
RUN pip install isso
# Install gevent
RUN pip install gevent
# Install gunicorn
RUN pip install gunicorn

# Add isso configuration
ADD isso.conf /opt/isso/isso.conf

VOLUME ["/opt/issodb", "/opt/isso"]

# Let some ports to be accessible if user add -p option to docker run
EXPOSE 8080

ENV ISSO_SETTINGS /opt/isso/isso.conf
# Launch supervisord at the beginning
CMD ["-k", "gevent", "-b", "0.0.0.0:8080", "-w", "4", "--preload", "isso.run"]
ENTRYPOINT ["/usr/local/bin/gunicorn"]
