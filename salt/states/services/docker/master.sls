include: 
  - services.docker.basic

docker-portainer-volume:
  cmd.run:
    - name: 'docker volume create portainer_data'
    - require:
      - sls: services.docker.basic

docker-portainer-container: 
  cmd.run:
    - name: 'docker run -d -p 8000:8000 -p 9000:9000 --name=Portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer'
    - require:
      - id: docker-portainer-volume

