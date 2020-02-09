## [![Alpine Build](https://img.shields.io/github/workflow/status/containercraft/ccio-nginx/DockerHubBuild/alpine?label=Alpine%20Build)](https://github.com/containercraft/ccio-nginx/actions) [![Docker Pulls](https://img.shields.io/docker/pulls/containercraft/ccio-nginx?label=DockerHub%20Pulls)](https://hub.docker.com/r/containercraft/ccio-nginx)  [Find on DockerHub](https://hub.docker.com/r/containercraft/ccio-nginx)

# CCIO Container Nginx Service 
    
### Simple [Nginx] service container running on [Alpine Linux]
```sh
sudo podman run \
    --rm                                                                                               \
    --detach                                                                                           \
    --name     ccio-nginx                                                                              \
    --publish  10.10.10.62:443:8843                                                                    \
    --publish  10.10.10.62:80:8080                                                                     \
    --volume   ~/.ccio/ocp-mini-stack/module/nginx/aux/html/:/var/www/html/:ro                         \
    --volume   ~/.ccio/ocp-mini-stack/module/nginx/aux/lib/default.conf:/etc/nginx/conf.d/default.conf \
  docker.io/containercraft/ccio-nginx
```
[Nginx]:https://www.nginx.com/
[Alpine Linux]:https://alpinelinux.org/
