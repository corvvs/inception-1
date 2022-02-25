# inception

## Info

42 cursus: docker project.

- Status: finished
- Result: pending evaluation
- Observations: (null)

## How to run

- run `make` or `make load` to start the docker-compose containers.
- run `make stop` to stop the containers.
- run `make prune` to stop the containers and/or delete the volumes.

## About this project

For this project we need to setup a simple docker-compose network with the following containers:

- NGINX with TLSv1.2 or TLSv1.3.
- Wordpress + php-fpm (installed and configured).
- MariaDB.

With the following volumes:

- A volume that contains Wordpress database.
- A volume that contains Wordpress website files.

Each docker container must have his own `Dockerfile` and, of course, have to restart in case of crash

Here is an example diagram of the expected result:

![diagram](https://github.com/izenynn/inception/blob/main/diagram.png)

I wanted to learn more about Docker so for this project I also do the bonus part, that part requires
us to setup 5 more containers:

- redis cache, for wordpress.
- FTP server pointing to the volume of the wordpress site.
- A static website (Some simple .html, .css and .js files is the web root, so wordpress is now in `website/wordpress`).
- Adminer (a simple tool to manage mysql).
- A service of my choice, I choose PhpMyAdmin because adminer is very simple.

In addition to the diagram above, I also open the ports 21, 21100-21110 for the FTP server.

Conclusion: now I like Docker and I enjoyed this a lot.

##
[![forthebadge](https://forthebadge.com/images/badges/built-with-science.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/it-works-why.svg)](https://forthebadge.com)
