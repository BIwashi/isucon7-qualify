FROM golang:1.9

COPY webapp/go /home/isucon/isubata/webapp/go
WORKDIR /home/isucon/isubata/webapp/go
RUN make

EXPOSE 5000

ENTRYPOINT ["/home/isucon/isubata/webapp/go/isubata"]
