download-plex:
  cmd.run:
    - name: 'wget -O /tmp/plex.deb {{pillar["download-url"]}}' 

install-plex:
  cmd.run:
    - name: 'dpkg -i /tmp/plex.deb'
    - require:
      - id: download-plex

remove-temporary-package-file:
  cmd.run:
    - name: 'rm /tmp/plex.deb'
    - require:
      - install-plex