# Pterodactyl Panel
Pterodactyl is the open-source game server management panel built with PHP7, Nodejs, and Go.

Modified version of [pterodactyl-docker](https://github.com/ccarney16/pterodactyl-docker).

### Volumes
MariaDB data **=>** `/srv/docker/pteropanel/data/db` 
Pterodactyl configuration **=>** `/srv/docker/pteropanel/data/ptero`

## Notes
Create the required directories and set the required permissions
```bash
mkdir -p /srv/docker/pteropanel/data 
cd /srv/docker/pteropanel/data
mkdir -m 750 db ptero
chown -R 1001:1001 db
chown -R 999:999 ptero
```
