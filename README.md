PSI Docker
===========

What we have
------------

- Ubuntu: 16.04
- Nginx
- php7
- Mariadb
- Nodejs 
- Mongodb
- Phpmyadmin

Usage
------

#### Build docker
`docker build -t [name_image] .`


#### Run container with image

`docker run -d -p 80:80 -p 3306:3306 -p 9000:9000 -p 27017:27017 -p 28017:28017 -v /var/www:/var/www/html/ -w /var/www/html/ [name_image]`

```
-d: Run process in a container as a daemon
-p: Map ports in container to port on host
-v: Map container html to host www directory
-w: Set working directory to /var/www/html
```
    

#### Check container_id
`docker ps `

#### Start services in running container
`docker exec -­it container_id run.sh`

#### Test container

`http://your_host_ip`

`http://your_host_ip/phpmyadmin (username: phpmyadmin/password: 1qa2ws3ed)`
