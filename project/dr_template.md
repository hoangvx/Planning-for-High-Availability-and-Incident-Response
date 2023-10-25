# Infrastructure

## AWS Zones
us-east-1: us-east-1a, us-east-1c us-east-1d
us-east-2: us-east-2a, us-east-2c us-east-2d

## Servers and Clusters

### Table 1.1 Summary
| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|------------|-------------------|------------------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| Asset name | Brief description | AWS size eg. t3.micro (if applicable, not all assets will have a size) | Number of nodes/replicas or just how many of a particular asset | Identify if this asset is deployed to DR, replicated, created in multiple locations or just stored elsewhere |
| EC2 | Runing application | t3.micro | 3 | Replicated in us-east-2 |
| EC2 | Runing application | t3.micro | 3 | DR in us-east-1 |
| EKS | For monitoring  | t3.medium | 3 | DR in us-east-1 |

### Descriptions
More detailed descriptions of each asset identified above.

## DR Plan
### Pre-Steps:
List steps you would perform to setup the infrastructure in the other region. It doesn't have to be super detailed, but high-level should suffice.

Ensure the infrastructure is set up and working in the DR site.

## Steps:
You won't actually perform these steps, but write out what you would do to "fail-over" your application and database cluster to the other region. Think about all the pieces that were setup and how you would use those in the other region

Create a cloud load balancer and point DNS to the load balancer. This way you can have multiple instances behind 1 IP in a region. During a failover scenario, you would fail over the single DNS entry at your DNS provider to point to the DR site. This is much more intelligent than pointing to a single instance of a web server.
Have a replicated database and perform a failover on the database. While a backup is good and necessary, it is time-consuming to restore from backup. In this DR step, you would have already configured replication and would perform the database failover. Ideally, your application would be using a generic CNAME DNS record and would just connect to the DR instance of the database.
