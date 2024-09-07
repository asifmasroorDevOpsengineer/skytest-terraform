### About
Terraform Code to deploy N servers and add a message in each server web proxy.
It will create:
* Full AWS VPC
* AWS EC2
* AWS Security Group
* AWS Load Balancer

## Create Terraform tfvars
Create a file called terraform.tfvars do define your variables, there is a file called "exampletfvars.tf" you can use it as example
## Shell Script Usage

  

To manage the cluster, use the provided shell script. Follow the instructions below:

Ensure that Terraform is installed on your system.

Make the shell script executable by running the following command:

  

```
chmod +x deploy.sh
```
  

Run the script using the following command:
 ``` deploy.sh```

  


  

The script will present a menu with the following options:

#### Get AWS Credentials

#### Start cluster: Install and starts the cluster.

#### Stop cluster: Stops the cluster.

#### Check cluster status: Checks the cluster status by making requests to the load balancer's health endpoint.
After cluster creation an output with ALB will be showed, just paste in the when required

#### Quit: Exits the script.

  

### Additional Notes

Customize the installation, start, stop, and status check commands in the shell script to match your cluster setup and requirements.
You can set different versions for the web servers and the load balancer by modifying the script accordingly.

  
#### What is missing?
* The current terraform version can deploy N servers but the first one will be assigne to Target group1 and the second one to Target Group 2, if many servers are created, it wont be added automatically to target groups and consequently to the Load Balancer
* I've tried to add for_each and counts to deploy " sets" of ec2, the whole ideia is from a file (config.yaml) be able to configure sets with different configurations, but unfortunatelly I dont have enough free time to accomplish. Needs more investigation about how to operate counts and for each statements in the across many aws resources

#### Despite these limitations, I hope that the presented code demonstrates my knowledge and effort in implementing the environment.
