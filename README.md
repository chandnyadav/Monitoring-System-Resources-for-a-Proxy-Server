# System Resource Monitoring Dashboard for Ubuntu

## Overview

The System Resource Monitoring Dashboard is a Bash script designed to provide real-time insights into system performance on Ubuntu. It displays critical information about CPU, memory, disk usage, network activity, and running services, making it an essential tool for system administrators and users who want to monitor their system's health.

## Features

- **Top 10 Applications by CPU and Memory Usage**: Displays the most resource-intensive applications.
- **Network Monitoring**: Shows active connections, data received, and transmitted.
- **Disk Usage**: Provides an overview of disk space usage and highlights filesystems that are over 80% full.
- **System Load**: Displays the system load averages and CPU usage breakdown.
- **Memory Usage**: Provides details on total, used, and free memory, including swap usage.
- **Process Monitoring**: Lists active processes and their CPU and memory usage.
- **Service Monitoring**: Checks the status of essential services like SSH, Nginx, and Apache.

## Installation

1. **Clone the Repository** (if applicable):
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Make the Script Executable**:
   ```bash
   chmod +x monitor.sh
   ```

3. **Run the Script**:
   ```bash
   ./monitor.sh
   ```

## Usage

The script can be run in two ways:

### 1. Full Dashboard

To run the full dashboard, simply execute the script without any arguments. The dashboard will refresh every 10 seconds.
```bash
./monitor.sh
```

### 2. Custom Options

You can also run specific sections of the dashboard by using command-line options:

- **CPU Load**: 
  ```bash
  ./monitor.sh -cpu
  ```

- **Memory Usage**: 
  ```bash
  ./monitor.sh -memory
  ```

- **Network Monitoring**: 
  ```bash
  ./monitor.sh -network
  ```

- **Disk Usage**: 
  ```bash
  ./monitor.sh -disk
  ```

- **Top Applications**: 
  ```bash
  ./monitor.sh -apps
  ```

- **Process Monitoring**: 
  ```bash
  ./monitor.sh -proc
  ```

- **Service Monitoring**: 
  ```bash
  ./monitor.sh -services
  ```

- **All Information**: 
  ```bash
  ./monitor.sh -all
  ```

### 3. Exiting the Dashboard

To exit the dashboard at any time, press `CTRL + C`.

## Customization

You can modify the refresh interval by changing the `INTERVAL` variable in the script. The default is set to 10 seconds.

```bash
INTERVAL=10
```

## Conclusion

This System Resource Monitoring Dashboard is a powerful tool for monitoring system performance in real-time. It provides essential insights that can help in maintaining system health and optimizing resource usage. For further enhancements or contributions, feel free to reach out or submit a pull request.
