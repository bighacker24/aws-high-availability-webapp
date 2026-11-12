# ADR 001: Single on-demand NAT Gateway

Status: Accepted
Date: 2026-11-12

## Context
App servers in the private subnets need outbound internet access for OS patches
and app updates. The project must stay as close to free as possible, and a NAT
Gateway bills every hour it exists.

## Options considered
- A. NAT Gateway: $0.045/hr + $0.045/GB in Ohio (~$32.85/month), plus $0.005/hr
  for its Elastic IP.
- B. Interface endpoints, no NAT: $0.01/hr per endpoint per AZ. Systems Manager
  needs three endpoints; across two AZs that costs more than one NAT.
- C. Public IPs on app servers: rejected because it exposes the app tier.

## Decision
One NAT Gateway in public_a, created only when enable_nat = true (default false).
Traffic path: app server -> NAT Gateway -> Internet Gateway. Outbound only;
nothing on the internet can start a connection to the app servers through the NAT.
The free S3 gateway endpoint stays on permanently, so S3 traffic never uses the NAT.

## Consequences
- Cost: about $0.05/hr only while switched on. Partial hours bill as full hours,
  so a 10-minute test costs one full hour.
- Single-AZ risk: if us-east-2a fails, app servers in us-east-2b also lose
  outbound access. Inbound traffic through the load balancer is unaffected.
- Switch off: no OS updates and no Systems Manager access. S3 still works.
- Safeguards: switch defaults to false; monthly budget alert; end-of-session check.
- Production would use one NAT per AZ, each with its own route table.
