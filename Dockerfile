# VERSION 0.2
FROM python:3.3
MAINTAINER Olivier Dossmann, <olivier+dockerfile@dossmann.net>

# Create directory to contains all Isso config + DB
RUN mkdir -p /opt/isso

# Install isso
RUN pip install gevent==1.1rc3 gunicorn

# Add isso configuration
ADD isso.conf /opt/isso/isso.conf

VOLUME ["/opt/issodb", "/opt/isso"]

# Let some ports to be accessible if user add -p option to docker run
EXPOSE 8080

ENV ISSO_SETTINGS /opt/isso/isso.conf
# Launch supervisord at the beginning
CMD ["-k", "gevent", "-b", "0.0.0.0:8080", "-w", "4", "--preload", "isso.run"]
ENTRYPOINT ["/usr/local/bin/gunicorn"]
