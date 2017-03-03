# Grafana and Influxdb stack setup for monitoring an ESXi/vCenter environment, using docker-compose

A combination of my [grafana-influxdb](https://github.com/szukalski/docker/tree/master/grafana-influxdb) and [vsphere-influxdb-json](https://github.com/szukalski/docker/tree/master/vsphere-influxdb-json) docker setups.

Provides a stack containing:
* Influxdb exposed on port 8086 with http authentication enabled (an admin user must be created as a first step).
* Grafana and vsphere-influxdb-json linked to the Influxdb container.
* vsphere-influxdb-json sending data to Influxdb.
* Persistent data stored as a volume. This can be modified with a volume driver to be a network share or whatever..

A configuration script is provided for use post deploy which will create:
* Admin user for Influxdb to write to the databases.
* Read-only user for Influxdb to read from the databases.
* Databases setup with read access to the read-only user.
* Databases added as datasource in Grafana.

# Run

[This](./run.sh) will deploy the stack but do no configuration.

Grafana admin password is set via [env.grafana](./env.grafana).

```

./run.sh

```

# Configure

Edit [this](./configure.sh) script for your own personalisation on usernames, passwords, databases, and the Grafana admin password you set during run.

```

./configure.sh

```

Afterwards, configure your [vsphere-influxdb-go.json](./vsphere-influxdb-go.json) to reflect the configuration details for Influxdb, and your ESXi/vCenter details.

# Upgrade

If there is a new IMAGE:latest then just do the run process again and it should pull the latest version.

