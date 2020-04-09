add-postgresql-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/pgdg.list
    - contents: 
      - 'deb http://apt.postgresql.org/pub/repos/apt/ {{ grains["oscodename"] }}-pgdg main'

import-postgresql-key: 
  cmd.run: 
    - name: 'wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -'
    - require:
      - id: add-postgresql-repo
    
install-postgresql:
  cmd.run:
    - name: 'apt-get update -qq && apt-get -y install postgresql-{{ pillar["psql-version"] }} postgresql-client-{{ pillar["psql-version"] }} && systemctl enable postgresql && systemctl stop postgresql' 
    - require:
      - id: import-postgresql-key

postgresql-hba:
  file.managed:
    - name: /etc/postgresql/{{pillar["psql-version"]}}/main/pg_hba.conf
    - contents: 
    {% for rule in pillar['psql-hba-rules'] %}
      - {{ rule }}
    {% endfor %}
    - require:
      - id: install-postgresql
  
postgresql-data-directory:
  file.replace:
    - name: /etc/postgresql/{{pillar["psql-version"]}}/main/postgresql.conf
    - pattern: data_directory = '/var/lib/postgresql/{{pillar["psql-version"]}}/main'    
    - repl: "data_directory = '{{pillar['psql-data-directory']}}'" 
  cmd.run: 
    - name: 'mv /var/lib/postgresql/{{pillar["psql-version"]}}/main {{pillar["psql-data-directory"]}}'

postgresql-listen-address:
  file.replace:
    - name: /etc/postgresql/{{pillar["psql-version"]}}/main/postgresql.conf
    - pattern: "#listen_addresses = 'localhost'"
    - repl: "listen_addresses = '*'"

start-postgresql:
  cmd.run:
    - name: 'systemctl start postgresql'
    - require:
      - id: postgresql-listen-address
      - id: postgresql-hba

postgresql-password: 
  cmd.run:
    - name: psql -c 'ALTER USER postgres WITH PASSWORD "{{ pillar["postgres-password"] }}"'
    - runas: postgres
    - require:
      - id: start-postgresql



