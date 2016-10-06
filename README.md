# InfluxDB proxy

A proxy for the HA architecture described in https://github.com/influxdata/influxdb-relay

## Run the container

    docker -e BACKEND_influxdb_a=influxdb-a:8086 -e BACKEND_influxdb_b=influxdb-b:8086 \
           -e RELAY_influxdb_a=influxdb-relay-a:9096 -e RELAY_influxdb_b=influxdb-relay-b:9096 \
           run appcelerator/haproxy-proxy

## Configuration

Variable | Description | Default value | Sample value 
-------- | ----------- | ------------- | ------------
BACKEND_xx | host:port of an influxDB backend | | influxdb-backend:8086 
RELAY_xx | host:port of an influxDB relay | | influxdb-relay:9096 
