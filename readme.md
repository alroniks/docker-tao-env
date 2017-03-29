
This gist with a bunch of files and scripts that will allow using TAO within docker containers. 

Below a little instruction how to use it:

1. At first you need download and install Docker and Docker Compose. (https://www.docker.com/products/overview)
2. Then you need download ZIP archive from GitHub Gist (https://gist.github.com/Alroniks/4a09104ef35198171e537e29b94bddb4)
3. After unzipping rename folder as you want. For example: taodoc. This name will be used as project_name.
4. Init: This step can be skipped, but if you use mac or linux it should work. Run `make init` in the folder with files. This script will patch project name in config by the name of the current folder.
5. Run containers: When configs were patched to run our environment `make up`. Docker will pull images and run containers. By default will be installed latest production release of TAO project. It can take a few minutes while all files from container with tao will be synced with host.
6. Add domain to /etc/hosts. Domain will be projectname.docker, for example taodoc.docker. 

Now you can go to http://taodoc.docker and start install by hands. Or run `make install` for installation in cli mode. 

For go inside container use `make shell`.

Also available commands: `make update` for updating project and `make down` for destroy container. Mysql container use shared data volume so you don’t need to install project after every `up`.
Full list of command in `Makefile`.

**Manual Installation**

Here a few screenshots with filled form fields in case when we use `taodoc` name. If you chose another name, replace taodoc by your name.

![Server Setup](/.docs/00.png?raw=true)

![Database Configuration](/.docs/01.png?raw=true)

**Troubleshooting.**

- Such as 80 port can be used only once in the system, `init` command has option PORT to set different port for instance. Ex: `make init PORT=2001`, by default 80. 
  For run some projects at the same time I use local nginx with proxied requests to docker instances. Example of config:

```
upstream mpart {
    server 0.0.0.0:2001;
}

server {
    listen 127.0.0.1:80;
    server_name taodoc.docker;
    root /Users/alroniks/dev/docker/taodoc;
    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_set_header X-NginX-Proxy true;
        proxy_pass http://taodoc;
    }
}
```

- Not sure that `make` command will work in Windows but should.
