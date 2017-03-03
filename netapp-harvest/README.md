# NetApp Harvest docker image

This is used to monitor NetApp cDOT and 7mode systems and push to a Graphite enabled database.

This is based on NetApp Harvest by [Christopher Madden](http://blog.pkiwi.com/) and the docker instructions by [Dan Burkland](http://www.dburkland.com/how-to-setup-netapp-harvest-using-docker/), however I wanted to make the stack components independent as in true Docker fashion (one process per container right?) and use this image as part of the stack I created [here](https://github.com/szukalski/docker/tree/master/grafana-influxdb-harvest).

Since the NetApp SDK and Harvest packages are not open-source, then they cannot be included here nor can the resultant docker image be stored in a public hub.

# Build

Get yourself the NetApp closed source components and place them in this directory:
* [netapp-harvest-1.3.zip](http://mysupport.netapp.com/tools/info/ECMLP2314554I.html?productID=61924)
* [netapp-manageability-sdk-5.6.zip](http://mysupport.netapp.com/NOW/download/software/nmsdk/5.6/netapp-manageability-sdk-5.6.zip)

The build the image:

```

./build.sh

```

# Configure

Create the Harvest role and create a Harvest user per node as shown in these files: [7mode](./configure_7mode.txt) and [cDOT](./configure_cdot.txt)

Add your Graphite-compatible server, Harvest user details, and filers into [netapp-harvest.conf](./netapp-harvest.conf), if you are using Grafana then you can put an API key and Grafana url in as well.

The [netapp-harvest.conf](./netapp-harvest.conf) is loaded as an external file, so you can change the configuration and restart the image to reload the configuration change (or log onto the container interactively and restart the harvest process, comme ci comme ça).

# Run

Make sure you have done the configuration and then do:

```

./run.sh

```

# Upgrade

Rebuild the image with newer NetApp tools.


