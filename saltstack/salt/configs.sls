{% set lsb_release = grains['lsb_distrib_codename'] %}

docker_repo:
  pkgrepo.managed:
    - hostname: docker
    - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ lsb_release }}
    - file: /etc/apt/sources.list.d/docker.list
    - key_url: salt://apt/sources/docker/apt-key.gpg

k8s_repo:
  pkgrepo.managed:
    - hostname: kubernetes
    - name: deb https://apt.kubernetes.io/ kubernetes-xenial main
    - file: /etc/apt/sources.list.d/kubernetes.list
    - key_url: salt://apt/sources/k8s/apt-key.gpg

dependencies:
  pkg.latest:
    - pkgs:
      - docker
      - python
  service.running:
    - name: docker
    - enable: True
