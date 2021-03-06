#!/bin/sh

# Source: http://kubernetes.io/docs/getting-started-guides/kubeadm/
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update
apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni
apt-get install -y locales locales-all
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

systemctl enable kubelet && systemctl start kubelet
systemctl enable docker && systemctl start docker

CGROUP_DRIVER=$(sudo docker info | grep "Cgroup Driver" | awk '{print $3}')

sed -i "s|KUBELET_KUBECONFIG_ARGS=|KUBELET_KUBECONFIG_ARGS=--cgroup-driver=$CGROUP_DRIVER |g" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

locale-gen UTF-8

systemctl daemon-reload

systemctl stop kubelet && systemctl start kubelet
