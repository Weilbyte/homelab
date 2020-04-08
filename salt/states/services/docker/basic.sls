install-docker:
  cmd.run:
    - name: 'curl -sSL https://get.docker.com/ | CHANNEL=stable bash'

enable-docker:
  cmd.run:
    - name: 'systemctl enable docker'
    - require:
      - id: install-docker

install-compose:
  cmd.run:
    - name: 'curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose'

chmod-compose:
  cmd.run:
    - name: 'chmod +x /usr/local/bin/docker-compose' 
    - require:
      - id: install-compose

docker-data-root: 
  file.managed:
    - name: /etc/systemd/system/docker.service.d/data-root.conf
    - makeDirs: True
    - contents:
      - '[Service]'
      - 'ExecStart=/usr/bin/dockerd --data-root /srv/docker/ -H fd:// --containerd:/run/containerd/containerd.sock'

apply-changes:
  cmd.run:
    - name: 'systemctl daemon-reload && systemctl restart docker'