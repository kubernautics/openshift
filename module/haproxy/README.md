haproxy load balancer & edge app router
sudo podman run -d --name ocp-haproxy -v ~/.ccio/ocp-mini-stack/module/haproxy/aux/lib/haproxy.cfg:/etc/haproxy.cfg:ro haproxy -c -f /etc/haproxy.cfg
