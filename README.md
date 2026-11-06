# aws-high-availability-webapp
Highly available AWS web application using ALB, EC2 Auto Scaling, RDS and Terraform.

## Project Overview

This project demonstrates the design and deployment of a highly available
web application on Amazon Web Services (AWS).

The infrastructure is designed to distribute application traffic across
multiple Availability Zones, automatically replace unhealthy compute
instances, and securely connect the application to a private database.

Infrastructure will be provisioned using Terraform to support repeatable
deployments and infrastructure management.

## Project Objectives

- Deploy a public Application Load Balancer (ALB).
- Run application servers in private subnets.
- Configure an EC2 Auto Scaling Group across two Availability Zones.
- Deploy Amazon RDS in private subnets.
- Apply IAM roles and security groups using least-privilege principles.
- Monitor infrastructure using Amazon CloudWatch.
- Test application resilience and instance recovery.
- Document infrastructure costs and cleanup procedures.
