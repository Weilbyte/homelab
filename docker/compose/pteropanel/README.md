# Pterodactyl Panel
Pterodactyl is the open-source game server management panel built with PHP7, Nodejs, and Go.

Modified version of [pterodactyl-docker](https://github.com/ccarney16/pterodactyl-docker).

### Volumes
MariaDB data **=>** `/srv/docker/pteropanel/db`      
Pterodactyl configuration **=>** `/srv/docker/pteropanel/ptero`

## Notes
Create the required directories and set the required permissions
```bash
sudo mkdir -p /srv/docker/pteropanel/ && cd /srv/docker/pteropanel/
sudo mkdir -m 750 db
sudo mkdir -m 755 ptero
sudo chown -R 1001:1001 db
sudo chown -R 999:999 ptero
```
