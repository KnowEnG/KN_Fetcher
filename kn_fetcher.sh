#!/bin/bash

BUCKET=$1
NETWORKTYPE=$2
TAXON=$3
EDGETYPE=$4
MYCMD="mkdir -p ~/.aws/ && cp /home/credentials ~/.aws/ && aws s3 cp s3://$BUCKET/$NETWORKTYPE/$TAXON/$EDGETYPE/ ./ --recursive"
echo $MYCMD
eval $MYCMD