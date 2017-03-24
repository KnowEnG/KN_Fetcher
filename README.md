
[![Docker Repository on Quay.io](https://quay.io/repository/cblatti3/kn_fetcher/status "Docker Repository on Quay.io")](https://quay.io/repository/cblatti3/kn_fetcher)


# KN_Fetcher
Download a subnetwork from the KnowEnG Knowledge Network

A repo for the `Dockerfile` to create a Docker image for the kn_fetcher.sh command. Also contains the
`Dockstore.cwl` which is used by the [Dockstore](https://www.dockstore.org) to register
this container and describe how to call kn_fetcher for the community.


## Building Manually

Normally you would let [Quay.io](http://quay.io) build this.  But, if you need to build
manually you would execute:

    docker build -t quay.io/cblatti3/kn_fetcher .


## Running Manually

```
# enter the docker container
$ docker run -it -w='/home/ubuntu' -v `pwd`:/home/ubuntu quay.io/cblatti3/kn_fetcher:latest

# run command within the docker container
$ /home/kn_fetcher.sh KnowNets/KN-6rep-1611/userKN-6rep-1611 Property 9606 pfam_domains
```
You'll then see a file, `9606.pfam_domains.edge`, in the current directory, that's the report file. The `-v` is used to mount this result out of the container.

## Running Through the Dockstore CLI

This tool can be found at the [Dockstore](https://dockstore.org/containers/quay.io/cblatti3/kn_fetcher), login with your GitHub account and follow the
directions to setup the CLI.  It lets you run a Docker container with a CWL descriptor locally, using Docker and the CWL command line utility.


### Make a Parameters JSON

A sample parameterization of the kn_fetcher tool is present in this repo in `kn_fetcher.job.yml`:

```
network_type: "Gene"
taxon: "9606"
edge_type: "STRING_textmining"
```

### Run with the CLI

Run it using the `dockstore` CLI:

```
Usage:
# fetch CWL
$ dockstore tool cwl --entry quay.io/cblatti3/kn_fetcher:latest > Dockstore.cwl

# make a runtime JSON template and edit it (or use the content of kn_fetcher.job.yml above)
$ dockstore tool convert cwl2json --cwl Dockstore.cwl > Dockstore.json

# run it locally with the Dockstore CLI
$ dockstore tool launch --entry quay.io/cblatti3/kn_fetcher:latest --yaml kn_fetcher.job.yml
```





docker build -t cblatti3/aws:0.1 ./
docker login
docker push cblatti3/aws:0.1