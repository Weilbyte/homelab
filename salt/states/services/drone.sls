include: 
  - services.docker.basic

docker-drone-volume:
  cmd.run:
    - name: 'docker volume create drone'
    - require:
      - sls: services.docker.basic

docker-drone-container:
  cmd.run:
    - name: 'docker run -d -p 80:80 --name=drone --restart=always -v drone:/data -e DRONE_USER_FILTER={{pillar["drone-user-filter"]}} -e DRONE_SERVER_PROTO={{pillar["drone-rpc-proto"]}} -e DRONE_SERVER_HOST={{pillar["drone-rpc-host"]}} -e DRONE_RPC_SECRET={{pillar["drone-rpc-secret"]}} -e DRONE_GITHUB_CLIENT_ID={{pillar["drone-github-client-id"]}} -e DRONE_GITHUB_CLIENT_SECRET={{pillar["drone-github-client-secret"]}} -e DRONE_USER_CREATE=username:{{pillar["drone-admin-username"]}},admin:true drone/drone:latest'
    - require:
      - id: docker-drone-volume

docker-runner-container:
  cmd.run:
    - name: 'docker run -d -p 3001:3001 --name=runner --restart=always -v /var/run/docker.sock:/var/run/docker.sock -e DRONE_RPC_PROTO={{pillar["drone-rpc-proto"]}} -e DRONE_RPC_HOST={{pillar["drone-rpc-host"]}} -e DRONE_RPC_SECRET={{pillar["drone-rpc-secret"]}} -e DRONE_RUNNER_CAPACITY=5 -e DRONE_RUNNER_NAME=runny drone/drone-runner-docker:latest'
    - require:
      - id: docker-drone-container