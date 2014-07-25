# VERSION 0.0
FROM ubuntu:12.04
MAINTAINER Olivier Dossmann, <olivier+dockerfile@dossmann.net>

# To avoid problems with Dialog and curses wizards
ENV DEBIAN_FRONTEND noninteractive

# Update list of packages
RUN apt-get update
# Install needed packages
RUN apt-get install -y python-dev python-pip sqlite3 supervisor openssh-server

# Configuration
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/run/supervisor
RUN echo 'root:isso' |chpasswd # change default root password

# Create directory to contains all Isso config + DB
RUN mkdir -p /opt/isso 

# Install isso
RUN pip install isso

# Configure supervisord
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add isso configuration
ADD isso.conf /etc/isso/isso.conf

VOLUME ["/opt/issodb", "/etc/isso"]

# Let some ports to be accessible if user add -p option to docker run
EXPOSE 8080 22

# Launch supervisord at the beginning
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
