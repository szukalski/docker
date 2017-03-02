# Docker image for vsphere-influxdb-go

All credit goes to [Oxalide](https://github.com/Oxalide) for this, I just wrapped a Dockerfile and docker-compose around it.

# Extenal dependencies

* [vsphere-influxdb-go](https://github.com/Oxalide/vsphere-influxdb-go)
* [govmomi](https://github.com/vmware/govmomi)
* [influxDB go client](https://github.com/influxdata/influxdb/tree/master/client/v2)

# Build

```

./build.sh

```

# Configure

You'll need a JSON file with all your vCenters/ESXi to connect to, the InfluxDB connection details(url, username/password, database to use), and the metrics to collect.

If you set a domain, it will be automaticaly removed from the names of the found objects.

Metrics collected are defined by associating ObjectType groups with Metric groups.
To see all available metrics, check out [this](http://www.virten.net/2015/05/vsphere-6-0-performance-counter-description/) page. 

Note: Not all metrics are available directly, you might need to change your metric collection level. 
A table with the level needed for each metric is availble [here](http://www.virten.net/2015/05/which-performance-counters-are-available-in-each-statistic-level/), and you can find a PowerCLI script that changes the collect level [here](http://www.valcolabs.com/2012/02/06/modify-historical-statistics-level-using-powercli/)

An example of configuration file is [here](./vsphere-influxdb-go.json).

This json configuration file is loaded as a volume during the docker-compose up, configure this before running the container

# Run

```

./run.sh

```

Requires docker-compose

# To-Do

Shrink the image size, this is massize for what it is. If I compile the go binaries and include them into the image then it will end up a lot smaller. But I am a lazy man and have other fish to fry..
