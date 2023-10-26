# Infrastructure

## AWS Zones
us-east-1: us-east-1b, us-east-1c
us-east-2: us-east-2a, us-east-2b

## Servers and Clusters

### Table 1.1 Summary
| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|------------|-------------------|------------------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| Asset name | Brief description | AWS size eg. t3.micro (if applicable, not all assets will have a size) | Number of nodes/replicas or just how many of a particular asset | Identify if this asset is deployed to DR, replicated, created in multiple locations or just stored elsewhere |
| EC2 | Runing application | t3.micro | 3 | Replicated in us-east-2 |
| EC2 | Runing application | t3.micro | 3 | DR in us-east-1 |
| EKS | For monitoring  | t3.micro | 1 cluster, 2 node | Replicated in us-east-2, create in multiple locations |
| EKS | For monitoring  | t3.micro | 1 cluster, 2 node | DR in us-east-1, create in multiple locations |
| VPC | For network | N/A | 1 | Replicated in us-east-2 |
| VPC | For network | N/A | 1 | DR in us-east-1 |
| ALB | For dns failover and HA | N/A | 1 | Replicated in us-east-2 |
| ALB | For dns failover and HA | N/A | 1 | DR in us-east-1 |
| RDS | For primary database  | t3.micro | 1 cluster, 2 node | Replicated in us-east-2, create in multiple locations, retention for 5 days |
| RDS | For secondary database | t3.micro | 1 cluster, 2 node | DR in us-east-1, create in multiple locations, retention for 5 days |
| S3  | For store teraform backend information | N/A | 1 | Store teraform setting, config for backend infrastructures |
| Github | For store teraform scripts | N/A | 1 | Using github action or codepipeline for CICD |

### Descriptions
EC2: For deploy application servers. Each region has tree instances to increase avaiability of application.
EKS: For deploy monitoring stack (prometheus and grafana). Each cluster have multiple node for hight avaiability.
VPC: For network layer. Each vpc has multiple AZs for high avaiability and secure apllication from outsite theads
ALB: For distribute income traffic and failover for DR setting.
RDS: For store application data with relational database. Each cluster has multiple node in multiple zone for high avaiability. All will setting with retetion policy of 5 days.
S3: For store backend infra information when running terraform.
Github: For store and version control of terraform scripts. Using github action as a tool for automation deploy IaC to AWS.

## DR Plan
### Pre-Steps:
1. Ensure the infrastructure is set up and working in the DR site.
2. Deploy IaC in both region for replicated and DR.

## Steps:
1. Create a cloud load balancer and point DNS to the load balancer. This way you can have multiple instances behind 1 IP in a region. During a failover scenario, you would fail over the single DNS entry at your DNS provider to point to the DR site. This is much more intelligent than pointing to a single instance of a web server.
2. Have a replicated database and perform a failover on the database. While a backup is good and necessary, it is time-consuming to restore from backup. In this DR step, you would have already configured replication and would perform the database failover. Ideally, your application would be using a generic CNAME DNS record and would just connect to the DR instance of the database.
