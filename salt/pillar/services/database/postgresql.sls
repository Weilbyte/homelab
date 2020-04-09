psql-hba-rules: [
    "#Default rules",
    "local   all             postgres                                peer",
    "local   all             all                                     peer",
    "host    all             all             127.0.0.1/32            md5",
    "host    all             all             ::1/128                 md5",
    "local   replication     all                                     peer",
    "host    replication     all             127.0.0.1/32            md5",
    "host    replication     all             ::1/128                 md5",
    "#Custom rules",
    "host    all             all             10.0.20.0/24            md5",
]

psql-version: '12'
psql-data-directory: '/srv/postgres-data'