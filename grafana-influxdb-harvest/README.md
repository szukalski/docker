# Grafana and Influxdb stack setup for monitoring a NetApp environment with Harvest, using docker-compose

A combination of my [grafana-influxdb](https://github.com/szukalski/docker/tree/master/grafana-influxdb) and [netapp-harvest](https://github.com/szukalski/docker/tree/master/netapp-harvest) docker setups.

Provides a stack containing:
* Influxdb exposed on port 8086 and 2003 with http authentication enabled (an admin user must be created as a first step).
* Influxdb configured with a Graphite plugin and Harvest template.
* Persistent data stored as a volume. This can be modified with a volume driver to be a network share or whatever..

A configuration script is provided for use post deploy which will create:
* Admin user for Influxdb to write to the databases.
* Read-only user for Influxdb to read from the databases.
* Databases setup with read access to the read-only user.
* Databases added as datasource in Grafana.

You need to build the [netapp-harvest](https://github.com/szukalski/docker/tree/master/netapp-harvest) image before-hand, there are non-open-source components which prevent it from being freely distributed.

# Run

[This](./run.sh) will deploy the stack but do no configuration.

Grafana admin password is set via [env.grafana](./env.grafana).

```

./run.sh

```

# Configure

Build the [netapp-harvest](https://github.com/szukalski/docker/tree/master/netapp-harvest) image as per instructions there, but keep your netapp-harvest.conf details locally in this directory.

Configure your database and grafana datasources by editing [configure.sh](./configure.sh) and running:

```

./configure.sh

```

# Upgrade

If there is a new IMAGE:latest then just do the run process again and it should pull the latest version.

