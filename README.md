Automated build of nginx with Docker
===========

### Nginx environment variables
Nginx will make of the following environment variables.

	NGINX_RUN_USER=www-data
	NGINX_RUN_GROUP=www-data
	NGINX_LOG_DIR=/var/log/nginx
	NGINX_BACKEND_IP=172.17.42.1
	NGINX_BACKEND_PORT=80
	NGINX_SERVER_NAME=localhost
	NGINX_SERVER_NAME_2=docker.localhost

### Use the pre built image
The pre built image can be downloaded using docker directly. After that you do not need to use this command again, you will have the image on your machine.

	$ sudo docker pull jacksoncage/nginx


### Build the docker image by yourself
If you prefer you can easily build the docker image by yourself. After this the image is ready for use on your machine and can be used for multiple starts.

	$ cd nginx-docker
	$ sudo docker build -t jacksoncage/nginx .


### Start the container
The container has all pre requisites set up to run any nginx application. Specify all needed environment variables.

	$ sudo docker run -i -d -p 80 -e NGINX_SERVER_NAME=jacksonacge.se jacksoncage/nginx


#### Start the container and keep control
The command above starts the container in deamon mode (-d) and runs in the background. If you want to start it by yourself just to see what happens use this command:

	$ sudo docker run -i -t -p 80 -e NGINX_SERVER_NAME=jacksonacge.se jacksoncage/nginx bash

Notice the two changes made here, first we replaced the deamon switch (-d) with the tty switch (-t) which pipes the std in and std out to your terminal.

You now end up as a root user in the docker container and can do simple things like ls, cd and more. More complex things can be achieved after a `apt-get install` of one or more software(s) of choice.

### Get the container ip and port
The first command inspects your created container and get the IPv4 address. Second command docker exported port for 8080.

    $ sudo docker inspect <container_id> | grep IPAddress | cut -d '"' -f 4
    $ sudo docker port <container_id> 80 | cut -d ":" -f2

Now go to `<your container's ip>:<container's port>` in your browser


### Stop the container
Stopping a running container is possible via the docker api. If only one instance of this container is running this command will stop it:

	$ sudo docker stop `sudo docker ps |grep jacksoncage/nginx |cut -d\  -f1`

