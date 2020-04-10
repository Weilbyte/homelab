base:
  '*':
    - provision
    - secrets.common
  'G@roles:postgresql':
    - secrets.postgresql
    - services.database.postgresql
  'G@roles:drone':
    - secrets.drone
    - services.drone