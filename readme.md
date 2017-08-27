# docker-tao-env

These configuration files and scripts make it easy to stand up a [TAO](https://www.taotesting.com) environment using docker containers.


## Setup

1. Download and install Docker and Docker Compose. (https://www.docker.com/products/overview)

2. Clone this repository or download a ZIP archive of this repo. Optionally, change the folder name of your repo (e.g. `taodoc` below).

  This name will be used as the project's name. For this configuration, the recommendation is to use _only_ alpha characters with no hyphens or underscores.

  ```
  git clone https://github.com/Alroniks/docker-tao-env taodoc
  ```

3. If you unzipped an archive, optionally rename the folder (e.g. `taodoc`) to define the project name.

4. `make init`: This step can be skipped, but if you use MacOS or Linux it should work. This script will apply the project name in config files using the name of the current folder.

  If you want to run on a port other than `80`, for example `8080`, run `make init PORT=8080`.

5. `make up`: Running this command will cause Docker to pull down the images and run the containers. By default the latest production release of TAO will be installed. It can take a few minutes for this to happen.

6. Add your domain to `/etc/hosts`. The default domain will be `projectname.docker`, for example `taodoc.docker`.


## Finish TAO installation

Now you can go to http://projectname.docker and complete the TAO web-based installation. Alternatively, you can run `make install` to complete a CLI installation.


### TAO Web-based Installation

Here a few screen shots with some form fields filled in with `taodoc` used as the project's name.

![Server Setup](/.docs/00.png?raw=true)

> **NOTE**: The database is configured by default to use the project name as the value for the database's name, the database admin's username, and the password for the database admin. Use `dbs` as the database's hostname. This is all configured in `docker-compose.yml`.

![Database Configuration](/.docs/01.png?raw=true)


## Maintenance

To log into the container use `make shell`.

Also available commands: `make update` for updating project and `make down` for destroy container. Mysql container use shared data volume so you don’t need to install project after every `up`.

Full list of command in `Makefile`.


## Troubleshooting

* Port 80 can only be used once in the system and it requires elevated privileges. Consider using `make init PORT=8080` as an alternative.

* To run multiple projects at the same time, use a local nginx configuration with proxied requests to the docker instances. Here is an example of the configuration:

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

* To run the `make` command in Windows, you might need the [GnuWin32](http://gnuwin32.sourceforge.net/packages/make.htm) utility.
