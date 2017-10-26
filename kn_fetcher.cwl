class: CommandLineTool
cwlVersion: v1.0
id: "kn_fetcher"
label: "Knowledge Network Fetcher"
doc: "Retrieve appropriate subnetwork from KnowEnG Knowledge Network from AWS S3 storage"

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/cblatti3/kn_fetcher:latest"
  - class: InlineJavascriptRequirement

hints:
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 1024 #"the process requires at least 1G of RAM
    outdirMin: 512000

inputs:
  - id: bucket
    label: "AWS S3 Bucket Name"
    doc: "the aws s3 bucket"
    type: string
    default: "KnowNets/KN-20rep-1706/userKN-20rep-1706"
    inputBinding:
      position: 1
  - id: network_type
    label: "Subnetwork Class"
    doc: "the type of subnetwork"
    type: string
    default: Gene
    inputBinding:
      position: 2
  - id: taxon
    label: "Subnetwork Species ID"
    doc: "the taxonomic id for the species of interest"
    type: string
    default: "9606"
    inputBinding:
      position: 3
  - id: edge_type
    label: "Subnetwork Edge Type"
    doc: "the edge type keyword for the subnetwork of interest"
    type: string
    default: PPI_physical_association
    inputBinding:
      position: 4

baseCommand: /home/kn_fetcher.sh

outputs:
  - id: output_file
    label: "Subnetwork Edge File"
    doc: "4 column format for subnetwork for single edge type and species"
    outputBinding:
      glob: "*.edge"
    type: File
