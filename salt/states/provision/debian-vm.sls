install-packages:
  cmd.run:
    - name: apt-get update -qq
  pkg.latest:
    - pkgs:
      {% for package in pillar['packages-debian'] %}
        - {{ package }}
      {% endfor %}

enable-services:
    service.running:
      {% for service in pillar['services-debian'] %}
      - name: {{ service }}
      {% endfor %}
      - enable: True
      - require:
        - id: install-packages

wheel-group:
  group.present:
    - name: wheel
    - system: false

wheel-enable:
  file.uncomment:
    - name: /etc/pam.d/su
    - regex: 'auth       required   pam_wheel.so'
  
wheel-sudoers:
  file.append:
    - name: /etc/sudoers
    - text: 
      - '# Passwordless wheel'
      - '%wheel ALL=(ALL) NOPASSWD: ALL'

disable-root:
  user.present:
    - name: root
    - shell: /sbin/nologin
  cmd.run:
    - name: passwd -l root

weil-account:
  user.present:
    - name: weil
    - fullname: Weilbyte
    - shell: /bin/bash
    - home: /home/weil
    - password: {{ pillar['weil-password'] }}
    - groups:
      - wheel
    - require:
      - id: wheel-group

weil-ssh-key:
  ssh_auth.present:
    - name: 'AAAAC3NzaC1lZDI1NTE5AAAAIHPqe4wmGc2Ir5P9F0gFwobsr22Z24GY99AUjuSoWI4J'
    - user: weil
    - enc: ed25519
    - comment: 'Weilbyte'

ssh-single-attempt:
  file.replace: 
    - name: /etc/ssh/sshd_config
    - pattern: '#MaxAuthTries 6'
    - repl: 'MaxAuthTries 1'

ssh-no-password:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: '#PasswordAuthentication yes'
    - repl: 'PasswordAuthentication no'
  
ssh-no-root-login:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: '#PermitRootLogin prohibit-password'
    - repl: 'PermitRootLogin no'

ssh-restart: 
  cmd.run:
    - name: 'systemctl restart sshd'
    - require:
      - id: ssh-single-attempt
      - id: ssh-no-password
      - id: ssh-no-root-login
