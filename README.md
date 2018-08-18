![Docker Build Status](https://img.shields.io/docker/build/knoweng/kn_fetcher.svg?style=flat-square)

# KN_Fetcher
Tool for downloading a specific subnetwork of the KnowEnG Knowledge Network

This repo contains the Python3 `kn_fetcher.py` script that performs the subnetwork extraction, a 
`Dockerfile` to create a Docker image, and a `Dockstore.cwl` that is used by the [Dockstore](https://www.dockstore.org) 
to register this Docker image container and describe how to call kn_fetcher for the community.

## Usage

### Inputs
There are four input parameters to this tool that must be specified on the command line in order.

**Position**|**Argument**  |**Description**|**Default**
--------|----------------|-----|-----
1     |BUCKET          |Name of S3 bucket where KN is stored|e.g. `KnowNets/KN-20rep-1706/userKN-20rep-1706`
2     |NETWORKTYPE |Type of subnetwork to be fetched|Must be `Gene` or `Property`
3     |TAXONID |Taxon identifier for species to be fetched|e.g. for human '9606'
4    |EDGETYPE |Keyword for subnetwork edgetype to be fetched|e.g. 'gene_ontology'

For example, to pull all the Gene Ontology annotations for human genes from the latest KN Build on S3:

    /home/kn_fetcher.sh KnowNets/KN-20rep-1706/userKN-20rep-1706 Property 9606 gene_ontology

To find the list of TAXONID identifiers supported by the current version of KnowEnG, please visit this [link](https://knoweng.org/kn-data-references/#kn_contents_by_species).

To find the list of EDGETYPE identifiers supported by the current version of KnowEnG, please visit this [link](https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type).

### Outputs
This output to this tool is three or four tab separated files in the current working directory.

##### A) TAXONID.EDGETYPE.edge - List of subnetwork edges 
- The columns of this file are defined as follows:
  1) Node1_id: the internal identifier for the source node of the edge
  2) Node2_id: the internal identifier for the target node of the edge
  3) Edge_weight: normalized weight of the edge in the subnetwork
  4) Edge_type: subnetwork edge type for the edge
  5) Source_id: internal identifier for the public source file the edge was extracted from 
  6) Line_num: original line number of edge information in the public source file

##### B) TAXONID.EDGETYPE.metadata - Subnetwork metadata
- This yaml file contains information about the extracted Knowledge Network subnetwork.  Its keys 
include summarizations about the network size (“data”), its public data source details (“datasets”), 
information about the meaning of its edges (“edge_type”), and some commands and configurations used 
in its construction (“export”).

##### C) TAXONID.EDGETYPE.node_map - Entity mapping information for subnetwork nodes
- The columns of this file are defined as follows:
  1) Internal_id: the internal identifier for a node in the subnetwork
  2) Mapped_id: the mapped internal identifier for a node in the subnetwork
  3) Node_type: type of node 'Gene' or 'Property'
  4) Node_alias: common name for network node
  5) Node_description: full name/description for network node

##### D) TAXONID.EDGETYPE.pnode_map - Entity mapping information for Property subnetwork nodes
- This file is produced only when `NETWORKTYPE` is `Property` and contains information nodes about the 
property nodes of the subnetwork in the same format as `C) TAXONID.EDGETYPE.node_map`.

### Default Usage With Docker
With Docker installed and your current directory the location you wish to download the subnetwork files, a simple command is needed: 

    docker run --rm -w=`pwd` -v `pwd`:`pwd` knoweng/kn_fetcher:latest \
        /home/kn_fetcher.sh KnowNets/KN-20rep-1706/userKN-20rep-1706 Property 9606 gene_ontology

You'll then see three or four files in the current directory. The `-w` sets the working directory for the container and the `-v` is used to volume mount the current directory to the container.

## Alternative Usages
#### With a CWL runner tool

A sample job parameters file for running a kn_fetcher job with a CWL tool runner is provided, `kn_fetcher.job.yml`: 

    network_type: "Gene"
    taxon: "9606"
    edge_type: "STRING_textmining"

This template can be modified as needed and passed with the kn_fetcher CWL description, `kn_fetcher.cwl`, for execution with a CWL runner tool.

#### Run without Docker
You can also run the tool directly without docker:

    git clone https://github.com/KnowEnG/KN_Fetcher.git
    cd KN_Fetcher
    ./kn_fetcher.sh KnowNets/KN-20rep-1706/userKN-20rep-1706 Property 9606 gene_ontology

#### Building Docker Image Manually

Normally you would use the `knoweng/kn_fetcher:latest` build image tag.  But if you need to build the image manually you would execute:

    git clone https://github.com/KnowEnG/KN_Fetcher.git
    cd KN_Fetcher
    docker build -t kn_fetcher .

## Current Knowledge Network Contents

A list of the current contents of the Knowledge Network can be found [here](Contents.md).
