# Keycloak web stack - Azure, Terraform, Ansible and Podman

Deployment and configuration of a static web server with Keycloak identity provider behind a SSL terminating reverse proxy.  
  
![main CI](https://github.com/paraskeuos/keycloak-azure/actions/workflows/rollout.yaml/badge.svg?branch=main)
![main CI](https://github.com/paraskeuos/keycloak-azure/actions/workflows/configure.yaml/badge.svg?branch=main)
![main CI](https://github.com/paraskeuos/keycloak-azure/actions/workflows/disassemble.yaml/badge.svg?branch=main)  

## Infrastructure

- AlmaLinux 9.6 VM (2 cpu / 4GB RAM)
- 1 virtual network
- 1 subnet
- 1 public IP
- Network security group allowing access to ports 22 and 443
- Blob container for Terraform remote state

Using managed identity with federated credentials for OIDC authentication within GitHub workflows.

Note: opening port 22 to public is not recommended, if necessary, SSH access should be possible through a bastion server.

## GitHub workflows

- rollout

Provisions the infrastructure and outputs the public IP address.

- configure

Configures the environment and deploys application pods and services. Uses the TF output public IP saved in remote state.

- disassemble

## Architecture

#### Podman

Daemonless and in this demo rootless, which addresses security concerns when using Docker.  

K8s-like pod declarations are used instead of inline commands or compose format:
- allows adding init containers where useful
- makes potential migration to K8s easier

#### systemd pod-level services

Podman currently does not support robust pod self-healing, that is handled through systemd user-scoped (rootless) services for each pod.

#### firewalld

As an additional layer of security, a VM firewall is used allowing ingress on ports 22 and 443.

## Pods 

- nginx reverse proxy

SSL termination with a self-signed certificate. This is the only entrypoint for web traffic.

- keycloak
- postres18
- oauth2-proxy

Enables quick setup of a necessary proxy for a web server that uses keycloak as identity provider.  

- nginx web server

Uses a static web page generated with general VM information.

## Possible improvements

- migrate to AKS and K8s resources
- use external secrets provider such as Hashicorp Vault
- use an ambassador sidecar container in keycloak pods for DB access and explore migrating the DB to managed Azure DB
- use Gateway API and compatible service mesh such as Istio
- introduce monitoring and autoscaling
