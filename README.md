# Build

Fetch this repository, then:

    docker build -t isso:latest .

You now have a kind of template to generate Isso containers.

# Prerequisites

Now you need some directories so that you can customize your Isso application (change server config, etc.): 

  * /srv/isso: to contain the configuration file (NB: docker user should have **read access** on this directory)
  * /srv/issodb: to contain the SQLite DB files (NB: docker user should have **write access** on this directory)

You should copy **isso.conf** into */srv/isso* directory and **configure it** (Cf [Official server configuration](http://posativ.org/isso/docs/configuration/server/)):

  * add a host, for an example `host = http://my.blog.com/`
  * change notify method by smtp: `notify = smtp`
  * then adapt smtp section to have the right configuration for your own email address

For an example:

    username = myId
    password = my2longPassword
    host = smtp.fai.tld
    port = 587
    security = starttls
    to = theAddressMail@youwant.tld
    from = "Name Surname" <takeme@domaine.tld>

You can now create the container to use this configuration file.

# Create a container

To run the container properly, you just need to define:

  * ports (to access to Isso)
  * volume (to link directories that Isso asked for and those you define on your local machine)

So run a container named **isso** like that: 

    docker run -d -p 8080:8080 --name isso -v /srv/isso/:/opt/isso -v /srv/issodb/:/opt/issodb isso:latest

Now you can access to isso via the **8080** port. To test it go to: [http://localhost:8080/demo](http://localhost:8080/demo).

# How to relaunch the server after some changes?

Just relaunch the docker file:

    docker stop isso
    docker start isso

It will do the trick.

# Integration

Pay attention to [configure your web server as explained in Isso documentation](https://posativ.org/isso/docs/quickstart/#running-isso) if it didn't remains on the same domain.

# Changelog

## Version 0.2

Use official python docker image to install Isso.

As [an issue occurs on gevent with gunicorn on Python 3](https://github.com/gevent/gevent/issues/515), I use a specific rc version of gevent.

## Version 0.1

gunicorn + gevent + Isso

As previous version makes 65 requests per second I change used tool to have more response time.

Now it makes 300 requests per second.

## Version 0.0

supervisord + Isso

65 requests/second
