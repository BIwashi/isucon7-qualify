FROM golang:1.9 AS build-dev

COPY bench /home/isucon/isubata/bench
COPY db /home/isucon/isubata/db
WORKDIR /home/isucon/isubata/bench
RUN \
  go get github.com/constabulary/gb/... && \
  gb vendor restore && \
  make && \
  bin/gen-initial-dataset

FROM mysql:5.7

ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes MYSQL_DATABASE=isubata MYSQL_USER=isucon MYSQL_PASSWORD=isucon

COPY --from=build-dev /home/isucon/isubata/db/isubata.sql /docker-entrypoint-initdb.d/01_isubata.sql
COPY --from=build-dev /home/isucon/isubata/bench/isucon7q-initial-dataset.sql.gz /docker-entrypoint-initdb.d/isucon7q-initial-dataset.sql.gz 

CMD ["--character-set-server=utf8mb4"]
