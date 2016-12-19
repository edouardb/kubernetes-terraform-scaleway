#!/usr/bin/env bash

. ./ips.txt
TOKEN=`python -c 'import random; print "%0x.%0x" % (random.SystemRandom().getrandbits(3*8), random.SystemRandom().getrandbits(8*8))'`
cat > scw-install.sh << FIN
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update -qq \
 && apt-get install -y -q --no-install-recommends kubelet kubeadm kubectl kubernetes-cni \
 && apt-get clean

for arg in "\$@"
do
  case \$arg in
    'master')
      suid=\$(scw-metadata --cached ID)
      public_ip=\$(scw-metadata --cached PUBLIC_IP_ADDRESS)
      private_ip=\$(scw-metadata --cached PRIVATE_IP)


      kubeadm --token=$TOKEN --api-advertise-addresses=\$public_ip --api-external-dns-names=\$suid.pub.cloud.scaleway.com init
      curl -O https://rawgit.com/kubernetes/dashboard/master/src/deploy/kubernetes-dashboard.yaml
      git clone https://github.com/kubernetes/heapster.git
      kubectl create -f http://docs.projectcalico.org/v2.0/getting-started/kubernetes/installation/hosted/kubeadm/calico.yaml
      kubectl create -f heapster/deploy/kube-config/influxdb/
      kubectl create -f kubernetes-dashboard.yaml
      break
      ;;
    'slave')
      kubeadm join --token $TOKEN $MASTER_00
      break
      ;;
 esac
done
FIN

rm -rf ./ips.txt
