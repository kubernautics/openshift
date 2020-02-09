## [![Alpine Build](https://img.shields.io/github/workflow/status/containercraft/ccio-haproxy/DockerHubBuild/alpine?label=Alpine%20Build)](https://github.com/containercraft/ccio-haproxy/actions) [![Docker Pulls](https://img.shields.io/docker/pulls/containercraft/ccio-haproxy?label=DockerHub%20Pulls)](https://hub.docker.com/r/containercraft/ccio-haproxy)  [Find on DockerHub](https://hub.docker.com/r/containercraft/ccio-haproxy)  |  [Repo Module](./module/haproxy)
# CCIO [HAProxy]: [Application Router] & [Load Balancer] 

#### 01\. Launch Simple [haproxy] service container running on [Alpine Linux]
```sh
sudo podman run 
    --rm                                                                                    \
    --detach                                                                                \
    --name     ocp-haproxy                                                                  \
    --publish  172.10.0.3:443:8843                                                          \
    --publish  172.10.0.3:80:8080                                                           \
    --publish  172.10.0.3:53:5353                                                           \
    --publish  172.10.0.3:69:6969                                                           \
    --publish  172.10.0.3:2022:22                                                           \
    --volume   ~/.ccio/ocp-mini-stack/module/haproxy/aux/config/:/usr/local/etc/haproxy/:ro \
  docker.io/containercraft/ccio-haproxy:latest
```

<!-- Markdown link & img dfn's -->
[Podman]:https://podman.io
[HAProxy]:https://haproxy.org
[Alpine Linux]:https://alpinelinux.org/
[Load Balancer]:https://blog.openshift.com/an-open-source-load-balancer-for-openshift/
[Application Router]:https://blog.openshift.com/ocp-custom-routing/
