base:
  '*':
    - provision
    - secrets.common
  'G@roles:postgresql':
    - secrets.postgresql
    - services.database.postgresql