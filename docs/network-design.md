

# AWS Network Design

## 1. VPC

- VPC CIDR: 10.0.0.0/16
- Availability Zones: 2

## 2. Public Subnets

| Subnet | CIDR | Purpose |
|---|---|---|
| Public A | 10.0.1.0/24 | Application Load Balancer |
| Public B | 10.0.2.0/24 | Application Load Balancer |

## 3. Private Application Subnets

| Subnet | CIDR | Purpose |
|---|---|---|
| App A | 10.0.11.0/24 | EC2 application servers |
| App B | 10.0.12.0/24 | EC2 application servers |

## 4. Private Database Subnets

| Subnet | CIDR | Purpose |
|---|---|---|
| DB A | 10.0.21.0/24 | RDS |
| DB B | 10.0.22.0/24 | RDS |

## 5. Network Security

- Public ALB accepts HTTP/HTTPS traffic.
- EC2 accepts application traffic only from the ALB security group.
- RDS accepts PostgreSQL traffic only from the EC2 security group.
- Database is not publicly accessible.

## 6. High Availability

- Deploy across two Availability Zones.
- Use an EC2 Auto Scaling Group.
- Configure an Application Load Balancer.
- Plan for RDS Multi-AZ deployment.



