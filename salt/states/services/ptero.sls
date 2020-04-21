include: 
  - services.docker.basic

add-node-repository:
  cmd.run:
    - name: 'curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -'

install-required-daemon-packages:
  cmd.run:
    - name: 'apt-get install -y nodejs make gcc g++ unzip tar'
    - require:
      - id: add-node-repository

install-node-gyp:
  cmd.run:
    - name: 'npm install -g node-gyp'
    - require:
      - id: install-required-daemon-packages

daemon-directories:
  cmd.run:
    - name: 'mkdir -p /srv/daemon /srv/daemon-data' 

daemon-unpack: 
  cmd.run:
    - name: 'curl -L https://github.com/pterodactyl/daemon/releases/download/v0.6.13/daemon.tar.gz | tar --strip-components=1 -xzv'
    - cwd: /srv/daemon
    - require:
      - id: daemon-directories

daemon-install-dependencies: 
  cmd.run:
    - name: 'npm install --only=production --no-audit --unsafe-perm'
    - cwd: /srv/daemon
    - require:
      - id: daemon-unpack

daemon-service: 
  file.managed:
    - name: /etc/systemd/system/wings.service
    - contents:
      - '[Unit]'
      - 'Description=Pterodactyl Wings Daemon'
      - 'After=docker.service'
      - ''
      - '[Service]'
      - 'User=root'
      - 'WorkingDirectory=/srv/daemon'
      - 'LimitNOFILE=4096'
      - 'PIDFile=/var/run/wings/daemon.pid'
      - 'ExecStart=/usr/bin/node /srv/daemon/src/index.js'
      - 'Restart=on-failure'
      - 'StartLimitInterval=600'
      - ''
      - '[Install]'
      - 'WantedBy=multi-user.target'


daemon-enable: 
  cmd.run:
    - name: 'systemctl enable docker && systemctl start wings && systemctl enable wings' 
    - require:
      - id: daemon-service