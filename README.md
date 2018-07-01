# Mongo Replica Set using Terraform

Allows creating several instances with MongoDB 3.2 enabling Replica set mode into all instances created. MongoDB Replica set infrastructure into VPC. It includes:

- Instance
- Security Group
- Elastic IP

## Consider Fault Tolerance

|Number of Members|Majority Required to Elect a New Primary	|Fault Tolerance|
|-----------------|---------------------------------------------|--------------:|
|3	          |2	                                        |1              |
|4	          |3	                                        |1              |
|5	          |3	                                        |2              |
|6	          |4	                                        |2              |

For this case, it was configurated 3 instances.

## Set Replica Set into Instances

1. `terraform apply`: Apply the changes required to builds instances with Mongo 3.2.

2. The replica Set configuration is a manual configuration yet. The steps to define it are:

	2.1. `rs.initiate()`: Initiate instance in Replica Set mode. Use it on one only one member of the replica set.
	2.2. `mongo`: Loggin into mongo to add other hosts.
	2.3. `rs.add( {host:"<host/ip:port>", priority: 0, votes: 0} )`: Add each one of instance to replica set. When a newly added secondary has its votes and priority settings greater than zero, during its initial sync, the secondary still counts as a voting member even though it cannot serve reads nor become primary because its data is not yet consistent.
	2.4. Once the newly added member has transitioned into SECONDARY state, use `rs.reconfig()` to update the newly added members priority and votes if needed.

      ```
      var cfg = rs.conf();
      cfg.members.forEach( function(member) {
          member.votes = 1;
          member.priority = 1;
        )
      });
      rs.reconfig(cfg);
      ```
	2.5. `rs.config()`: Show new configuration.

## Commands

`terraform init`    -> Initialize terraform

`terraform plan`    -> Show plan description from files

`terraform apply`   -> Apply plan

`terraform destroy` -> Destroy plan

## Considerations

- This project uses terraform to build all elements into Amazon.
- Create `<home path>/.aws/credentials` with access and secrets key to AWS.
- This project needs a VPC with subnet to can build infrastructure.

References
---

[https://www.terraform.io/](https://www.terraform.io/)
[https://docs.mongodb.com/v3.2/tutorial/expand-replica-set/](https://docs.mongodb.com/v3.2/tutorial/expand-replica-set/)
