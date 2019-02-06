FROM golang
MAINTAINER David James <szukalski@gmail.com>

RUN go get github.com/vmware/govmomi && \
	go get github.com/influxdata/influxdb/client/v2 && \
	go get github.com/oxalide/vsphere-influxdb-go

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]