haproxy load balancer & edge app router

sudo podman run -it -d --name ocp-haproxy -p 443:443 -v ~/.ccio/ocp-mini-stack/module/haproxy/aux/lib/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro haproxy:latest
