#!/bin/bash

run_stage () {
cat <<EOF >/tmp/resolv.conf
nameserver ${ocp_ministack_SUBNET}.3
nameserver ${ocp_ministack_SUBNET}.1
nameserver 1.1.1.1
EOF
}

run_replace () {
sudo mv /etc/resolv.conf /etc/resolv.conf.bak
sudo mv /tmp/resolv.conf /etc/resolv.conf
}

run () {
run_stage
run_replace
}

run
