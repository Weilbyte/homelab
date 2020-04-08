include: 
  - services.docker.basic

docker-agent-container:
  - cmd.run:
    - name: 'docker run -d -p 9001:9001 --name=Agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /srv/docker/volumes:/var/lib/docker/volumes portainer/agent'
    - require:
      - sls: services.docker.basic