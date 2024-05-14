
# Kubernetes Debugging Container

This repository contains a Docker image designed to assist in debugging Kubernetes issues, particularly related to network connectivity and other common problems. The image is based on Alpine Linux and includes a variety of tools to help with troubleshooting.

## Overview

This Docker image provides a lightweight and versatile environment for diagnosing and resolving Kubernetes issues. It includes a range of essential tools for network testing, monitoring, and general troubleshooting.

## Included Tools

The following tools are pre-installed in the container:

- **bind-tools**: Utilities for DNS querying.
- **conntrack-tools**: Tools for network connection tracking.
- **curl**: Command line tool for transferring data with URLs.
- **fping**: A ping-like program that uses ICMP echo requests to determine the status of network hosts.
- **git**: Version control system.
- **htop**: Interactive process viewer.
- **iperf3**: Network bandwidth measurement tool.
- **iproute2**: Utilities for controlling TCP/IP networking and traffic control.
- **ipset**: IP set manipulation tools.
- **iputils**: Collection of utilities for monitoring and managing IP networks.
- **jq**: Command-line JSON processor.
- **net-tools**: A collection of programs for controlling the network subsystem of the Linux kernel.
- **nmap**: Network exploration tool and security scanner.
- **nmap-ncat**: Network connectivity tool.
- **nmap-scripts**: Scripting engine for nmap.
- **openssh**: Secure shell (SSH) tools.
- **openssl**: Toolkit for the TLS and SSL protocols.
- **tcpdump**: Packet analyzer.
- **vim**: Text editor.
- **wget**: Network downloader.
- **zsh**: Z shell, a powerful command interpreter.

Additionally, the container is configured with `oh-my-zsh`, along with the `zsh-autosuggestions` plugin and the `powerlevel10k` theme for an enhanced command-line experience.

## Installation

To pull the Docker image, run the following command:

```sh
docker pull truestory1/alpine-netops
```

## Usage

### Running in Docker

You can run the container interactively to start troubleshooting:

```sh
docker run -it --rm truestory1/alpine-netops
```

### Running in Kubernetes

#### As a Standalone Pod

To run the container in a specific Kubernetes namespace, you can create a standalone pod:

1. Create a file named `debug-pod.yaml` with the following content:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: debug-pod
      namespace: <your-namespace>
    spec:
      containers:
        - name: debug-container
          image: truestory1/alpine-netops
          stdin: true
          tty: true
    ```

2. Apply the configuration to your Kubernetes cluster:

    ```sh
    kubectl apply -f debug-pod.yaml
    ```

3. Access the pod:

    ```sh
    kubectl -n <your-namespace> exec -it debug-pod -- zsh
    ```

#### As a Sidecar

To run the container as a sidecar in an existing pod, you can modify the pod's configuration. Here is an example of adding the debug container as a sidecar:

1. Edit the deployment file (e.g., `deployment.yaml`) of your application to include the sidecar container:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: your-app
      namespace: <your-namespace>
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: your-app
      template:
        metadata:
          labels:
            app: your-app
        spec:
          containers:
            - name: your-app-container
              image: your-app-image
              # your app container specs
            - name: debug-container
              image: truestory1/alpine-netops
              stdin: true
              tty: true
    ```

2. Apply the updated configuration:

    ```sh
    kubectl apply -f deployment.yaml
    ```

3. Access the debug container in the pod:

    ```sh
    kubectl -n <your-namespace> exec -it <your-pod-name> -c debug-container -- zsh
    ```

## Use Cases

### Network Connectivity

- **DNS Queries**: Use `dig` from the `bind-tools` package to query DNS records.
- **HTTP Requests**: Use `curl` to test HTTP endpoints.
- **Ping Hosts**: Use `fping` to check the reachability of hosts.
- **Network Performance**: Use `iperf3` to measure network bandwidth between nodes.

### System Monitoring

- **Process Monitoring**: Use `htop` to view and manage system processes interactively.
- **Network Analysis**: Use `tcpdump` to capture and analyze network traffic.

### General Troubleshooting

- **Configuration Editing**: Use `vim` to edit configuration files.
- **Version Control**: Use `git` to manage code and configuration changes.
- **JSON Processing**: Use `jq` to parse and process JSON data.

## Custom Configuration

The container includes a custom `.zshrc` configuration file, which sets up `oh-my-zsh` with useful plugins and themes. You can modify this configuration by editing the `configs/zshrc` file and rebuilding the image.

## Conclusion

This Docker image provides a robust toolkit for debugging Kubernetes issues, particularly those related to network connectivity. With a range of powerful tools and a customizable shell environment, it can significantly streamline the troubleshooting process.
