FROM mongo:4.2
COPY ./init-db.js /docker-entrypoint-initdb.d/init-db.js