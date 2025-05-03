# System Resource Monitoring Dashboard for Ubuntu

This script is a Bash-based system resource monitoring dashboard designed for Ubuntu. It provides real-time insights into various system metrics, including CPU and memory usage, network activity, disk usage, system load, memory usage, process monitoring, and service status. The dashboard is user-friendly and color-coded for better readability.

## Features

- **Top 10 Applications by CPU and Memory Usage**: Displays the top 10 applications consuming the most CPU and memory resources.
- **Network Monitoring**: Shows active network connections, data received, data transmitted, and packet drops.
- **Disk Usage**: Provides an overview of disk usage for all mounted filesystems, highlighting those that are over 80% full.
- **System Load**: Displays the system load averages over 1, 5, and 15 minutes, along with CPU usage percentages for user, system, and idle states.
- **Memory Usage**: Reports total, used, and free memory, including swap memory statistics.
- **Process Monitoring**: Lists active processes, showing the top consumers of CPU and memory.
- **Service Monitoring**: Checks the status of key services (e.g., SSH, Nginx, Apache2) and indicates whether they are running or stopped.

## Usage

### Running the Script

To run the script, save it as `monitor.sh` and execute it in the terminal:

```bash
bash monitor.sh
```

### Command-Line Options

You can run the script with specific options to view particular metrics:

- `-cpu`: Display system load.
- `-memory`: Display memory usage.
- `-network`: Display network monitoring.
- `-disk`: Display disk usage.
- `-apps`: Display top applications by CPU and memory usage.
- `-proc`: Display process monitoring.
- `-services`: Display service monitoring.
- `-all`: Display the full dashboard.

### Example

To view the full dashboard, simply run:

```bash
bash monitor.sh -all
```

## Code Explanation

### Color Definitions

The script defines several color codes for terminal output to enhance readability:

```bash
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'  # No Color
```

### Banner Function

The `banner` function clears the terminal and displays a title banner for the dashboard.

### Monitoring Functions

Each monitoring aspect is encapsulated in its own function:

- **`top_apps`**: Retrieves and displays the top 10 applications by CPU and memory usage.
- **`network_monitor`**: Gathers network statistics, including active connections and data transfer.
- **`disk_usage`**: Checks disk usage and highlights filesystems that are nearly full.
- **`system_load`**: Displays system load averages and CPU usage percentages.
- **`memory_usage`**: Reports memory and swap usage statistics.
- **`process_monitoring`**: Lists active processes and their resource consumption.
- **`service_monitoring`**: Checks the status of essential services.

### Full Dashboard Function

The `full_dashboard` function calls all the monitoring functions in sequence to provide a comprehensive view of system resources.

### Custom Switches

The script allows for custom command-line switches to run specific monitoring functions based on user input.

### Looping Behavior

If no options are provided, the script runs the full dashboard in a loop, refreshing every 10 seconds.

## Conclusion

This script is a powerful tool for monitoring system resources on Ubuntu, providing essential insights for system administrators and users alike. Customize and extend it as needed to fit your monitoring requirements.

