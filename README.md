# Azure Databricks deployment with on-premises connectivity

### Code structure
The taken approach of the Terraform code structure is a layered and a modularized one.

Layered deployment would mean that firstly the "base" infrastructure components, such as resource groups and virtual networks are deployed. The second layer would deploy storage, secrets, etc. The next layer deploys managed services, such as VMs, Kubernetes, etc.

Modularized deployment of the TF code has the following benefits:

1. reusability: the module can be called independently from other TF projects.
2. maintenance: the module can be versioned separately.
3. readability: fewer logically grouped lines.

### Exercise considerations
Since this is an exercise, the TF modules are hosted in the same repository.

In an enterprise environment, we could host each module in its own repository. This would allow independent development, versioning and reusability. It would also split the infrastructure in several `.tfstate` files.

Also, the `.tfstate` file is saved locally on disk.

In a working environment, we would save the file in a remote backend. For example, on AWS S3 with DynamoDB for state locking.

### Modules
#### Network
Deploys the base network layer.

#### Transit connectivity
Deploys a transit virtual network for on-premises connectivity.

#### Virtual network peering
Peers two virtual networks.

#### Storage
Deploys a storage account and a container.

#### Databricks
Databricks service deployment.

### TODO
It would be nice to develop a tagging module with common infrastructure tags.
