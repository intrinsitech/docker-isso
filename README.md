# Build

Fetch this repository, then:

    docker build -t isso:latest .

Now you need to open ports and mount volume to your container, for an example create these directories:

  * /srv/isso/conf: to contain the configuration (so that it could be changed/adapted)
  * /srv/isso/db: to contain all comments

Then run the container named **isso**:

    docker run -d -P --name isso -v /srv/isso/conf:/etc/isso -v /srv/isso/db:/opt/issodb isso:latest /usr/bin/supervisord

Now you can access to isso via the **8080** port.
