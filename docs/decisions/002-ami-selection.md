# ADR 002: Latest Amazon Linux image vs. pinned image

Status: Accepted
Date: 2026-11-17

## Context
The launch template reads the Amazon Linux 2023 image ID from a public AWS
parameter at plan time. On 2026-11-17, a teardown plan unexpectedly included an
image change (ami-0df8a753693e6366d to ami-0b96a5de4855a23d0) because AWS
published a new image that day. The code had not changed.

## Options considered
- A. Latest image from the parameter: every launch gets current patches, with no
  maintenance. Plans can change without a code change.
- B. Pinned image ID in a variable: every image change is a reviewed commit, but
  someone must update it or images go stale.
- C. Image pipeline (EC2 Image Builder): builds and tests hardened images,
  including STIG hardening components, before they reach the launch template.

## Decision
Option A for now. Option C (a STIG-hardened Image Builder pipeline) is
planned as Mission 027, after the core architecture is complete.

## Consequences
- Plans may show image updates with no code change; reviewers must expect this.
- Every new image is checked for Amazon's owner ID (137112412989) before applying.
- Running servers are not affected until they are replaced.
- A regulated production environment should use B or C, so every image change is
  reviewed and tested before servers boot from it.
