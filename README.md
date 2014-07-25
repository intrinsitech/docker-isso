# Build

Fetch this repository, then:

    docker build -t isso:latest .

Now you need to open ports and mount volume to your container, for an example create this directory:

  * /srv/isso: to contain the configuration file (so that it could be changed/adapted) and the SQLite DB file

Then run the container named **isso**:

    docker run -d -p :8080 --name isso -v /srv/isso/:/opt/isso isso:latest /usr/bin/supervisord

Now you can access to isso via the **8080** port.
