# VERSION 0.0
FROM ubuntu:14.04
MAINTAINER Olivier Dossmann, <olivier+dockerfile@dossmann.net>

# To avoid problems with Dialog and curses wizards
ENV DEBIAN_FRONTEND noninteractive

# Update list of packages
RUN apt-get update
# Install needed packages
RUN apt-get install -y python-setuptools python-virtualenv supervisor

# Create directory and install isso
RUN mkdir -p /opt/isso && \
  virtualenv /opt/isso && \
  source /opt/isso/bin/activate && \
  pip install isso

# Configure supervisord
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add isso configuration
RUN mkdir -p /opt/issodb && \
  mkdir -p /etc/isso
ADD isso.conf /etc/isso/isso.conf

VOLUME ["/opt/issodb", "/etc/isso"]

# Let some ports to be accessible if user add -p option to docker run
EXPOSE 8080

# Launch supervisord at the beginning
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
