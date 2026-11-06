import ipaddress

vpc = ipaddress.ip_network("10.0.0.0/16")

subnets = [
    ipaddress.ip_network("10.0.1.0/24"),
    ipaddress.ip_network("10.0.2.0/24"),
    ipaddress.ip_network("10.0.11.0/24"),
    ipaddress.ip_network("10.0.12.0/24"),
    ipaddress.ip_network("10.0.21.0/24"),
    ipaddress.ip_network("10.0.22.0/24"),
]

print(f"VPC: {vpc}")
print(f"Total subnets: {len(subnets)}")

for subnet in subnets:
    if subnet.subnet_of(vpc):
        import ipaddress

vpc = ipaddress.ip_network("10.0.0.0/16")

subnets = [
    ipaddress.ip_network("10.0.1.0/24"),
    ipaddress.ip_network("10.0.2.0/24"),
    ipaddress.ip_network("10.0.11.0/24"),
    ipaddress.ip_network("10.0.12.0/24"),
    ipaddress.ip_network("10.0.21.0/24"),
    ipaddress.ip_network("10.0.22.0/24"),
]

for subnet in subnets:
    if subnet.subnet_of(vpc):
        print(f"PASS: {subnet} belongs to the VPC")
    else:
        print(f"FAIL: {subnet} is outside the VPC")

overlap_found = False

for i in range(len(subnets)):
    for j in range(i + 1, len(subnets)):
        if subnets[i].overlaps(subnets[j]):
            print(f"FAIL: {subnets[i]} overlaps {subnets[j]}")
            overlap_found = True

if not overlap_found:
    print("PASS: No overlapping subnet ranges found.")

print("Network validation complete.")


