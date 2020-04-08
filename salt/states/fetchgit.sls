add-update-script: 
  file.managed:
    - name: /usr/local/bin/fetchgit
    - contents:
      - '#!/bin/bash'
      - 'cd /srv/homelab'
      - 'git fetch --all'
      - 'git reset --hard origin/master'
      - 'ln -s -f /srv/homelab/salt/states/* /srv/salt'
      - 'ln -s -f /srv/homelab/salt/pillar/* /srv/pillar'

chmod-update-script:
  cmd.run:
    - name: 'chmod +x /usr/local/bin/fetchgit'
    - require:
      - id: add-update-script

add-update-cron:
  cron.present:
    - identifier: fetchgit-cron
    - name: '/usr/local/bin/fetchgit'
    - minute: '*/25'