# Exercise: Azure Databricks deployment with on-premises connectivity
![Alt text](architecture.png)

### Code structure
The taken approach of the Terraform code structure is a layered and a modularized one.
Layered deployment would mean that firstly the "base" infrastructure components, such as resource groups and virtual networks are deployed. The second layer would deploy storage, secrets, etc. The next layer deploys managed services, such as VMs, Kubernetes, etc.

Modularized deployment of the TF code has the following benefits:

1. reusability: the module can be called independently from other TF projects.
2. maintenance: the module can be versioned separately.
3. readability: fewer logically grouped lines.

### Exercise considerations
#### About the modules
Since this is an exercise, the TF modules are hosted in the same repository.

In an enterprise environment, we could host each module in its own repository. This would allow independent development, versioning and reusability. It would also split the infrastructure in several `.tfstate` files.

#### About the Tfstate
Also, the `.tfstate` file is saved locally on disk.

In a working environment, we would save the `.tfstate` in a remote backend. For example, on AWS S3 with DynamoDB for state locking.

#### About scaling
The current implementation provides intial functionality. If we had to scale out, the modules would have to be adapted.

For example, the `vnet_peering` module currently only supports peerings in the same resource group and region.

### TF Modules
#### Network
Deploys the base network layer.

#### Transit connectivity
Deploys a transit virtual network for on-premises connectivity.

#### Virtual network peering
Peers two virtual networks.

#### Storage
Deploys a storage account and a container. Optionally deploys a Private Endpoint.

#### Databricks
Databricks workspace deployment with vnet injection.

### Usage

1. Checkout the git repository
2. Navigate to ./terraform
3. Execute
 - `terraform init` to initialize the terraform directory 
 - `terraform plan -out=demo.tfplan` to output a plan and save it to a file
 - `terraform apply demo.tfplan` to provision the infrastructure from the saved file
 - `terraform destroy` to destroy the infrastructure (with a prompt)

### TODO
- It would be nice to develop a tagging module with common infrastructure tags.
- Security & threat analysis.
- Scaling analysis: where could a bottleneck occur?
