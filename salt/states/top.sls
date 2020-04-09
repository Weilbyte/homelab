base:
  'G@os:Debian':
    - provision.debian-vm
  'G@roles:docker-agent':
    - services.docker.basic
    - services.docker.agent
  'G@roles:docker-master':
    - services.docker.basic
    - services.docker.master
  'G@roles:postgresql':
    - services.database.postgresql
   