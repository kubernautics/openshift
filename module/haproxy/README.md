# [HAProxy] [Application Router] & [Load Balancer]

#### 01\. Launch [HAProxy] Container with [Podman]
```sh
sudo podman run -d --name ocp-haproxy -p 443:443 -p 80:80 -p 2022:2022 -v ~/.ccio/ocp-mini-stack/module/haproxy/aux/lib/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro -v ~/.ccio/ocp-mini-stack/module/haproxy/aux/lib/errors/:/usr/local/etc/haproxy/errors:ro  haproxy:latest
```

<!-- Markdown link & img dfn's -->
[Podman]:https://podman.io
[HAProxy]:https://haproxy.org
[Load Balancer]:https://blog.openshift.com/an-open-source-load-balancer-for-openshift/
[Application Router]:https://blog.openshift.com/ocp-custom-routing/
