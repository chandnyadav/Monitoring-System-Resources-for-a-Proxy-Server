#!/bin/bash

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'

INTERVAL=10

# Title banner
banner() {
  clear
  echo "+------------------------------------------------------------+"
  printf "|%60s|\n" " "
 echo -e  "|   ${CYAN}SYSTEM RESOURCE MONITORING DASHBOARD UBUNTU${NC}         |"
  echo "+------------------------------------------------------------+"
echo
 echo

}

# 1. Top 10 Applications by CPU and Memory
top_apps() {
  echo "+------------------------------------------------------------+"
  echo -e "|   ${CYAN} TOP 10 APPLICATIONS (CPU & MEMORY USAGE)${NC}                 |"
  echo "+------+----------------------+----------+----------+"
  echo -e  "| ${BLUE}PID${NC}  | ${BLUE}Command${NC}          |${BLUE}%CPU${NC}     |${BLUE}%MEM${NC}     |"
  echo "+------+----------------------+----------+----------+"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | tail -n +2 | head -n 10 | \
  awk '{printf "| %-4s | %-20s | %-8s | %-8s |\n", $1, $2, $3"%", $4"%"}'
echo "+------+----------------------+----------+----------+"
echo
echo


}

# 2. Network Monitoring
network_monitor() {
  connections=$(netstat -ntu | tail -n +3 | wc -l)
  in_bytes=$(cat /proc/net/dev | awk '/:/ {sum+=$2} END {print sum/1024/1024}')
  out_bytes=$(cat /proc/net/dev | awk '/:/ {sum+=$10} END {print sum/1024/1024}')
  drops=$(netstat -s | grep -i "dropped" | awk '{sum+=$1} END{print sum}')
  [[ "$drops" == "" ]] && drops=0

  echo "+------------------------------------------------------------+"

echo -e "|   ${CYAN} NETWORK MONITORING  ${NC}                         |"
  echo "+------------------------------------------------------------+"
  printf "| ${BLUE}Active Connections${NC}  : %-6s      |  ${BLUE}Packet Drops${NC} : %-6s      |\n" "$connections" "$drops"
  printf "| ${BLUE}Data Received${NC}     : %-8s MB | ${BLUE}Data Transmitted${NC} : %-8s MB |\n" "$(printf "%.2f" $in_bytes)" "$(printf "%.2f" $out_bytes)"
  echo "+------------------------------------------------------------+"
echo
echo

}

# 3. Disk Usage
disk_usage() {
  echo "+--------------------------------------------------+"

echo -e "|   ${CYAN} DISK USAGE   ${NC}                 |"

  echo "+-----------------+--------+---------------------+"
  echo -e  "| ${BLUE}Filesystem${NC}      | ${BLUE}Usage${NC}  | ${BLUE}Mount${NC}               |"
  echo "+-----------------+--------+---------------------+"
  df -h --output=source,pcent,target | tail -n +2 | \
    while read fs pcent mnt; do
      use=${pcent%\%}
      if [ "$use" -ge 80 ]; then
        printf "| %-15s | ${RED}%-6s${NC} | %-19s |\n" "$fs" "$pcent" "$mnt"
      else
        printf "| %-15s | %-6s | %-19s |\n" "$fs" "$pcent" "$mnt"
      fi
    done
  echo "+-----------------+--------+---------------------+"
echo
echo

}

# 4. System Load
system_load() {
  load_avg=$(uptime | awk -F'load average: ' '{ print $2 }')
  cpu_line=$(top -bn1 | grep '%Cpu(s)')
  user=$(echo $cpu_line | awk '{print $2}')
  system=$(echo $cpu_line | awk '{print $4}')
  idle=$(echo $cpu_line | awk '{print $8}')

  echo "+------------------------------------------------------------+"

echo -e "|   ${CYAN}  SYSTEM LOAD     ${NC}                 |"

  echo "+------------------------------------------------------------+"
  printf "| ${BLUE}Load Avg${NC}  (${BLUE}1${NC} /${BLUE}5${NC} /${BLUE}15min${NC} ): %-38s|\n" "$load_avg"
  echo "+---------------------+-------------------+-----------------+"
  printf "| ${BLUE}User(%%)${NC}      | ${BLUE}System(%%)${NC}    | ${BLUE}Idle(%%)${NC}         |\n"
  printf "| %-11s | %-11s | %-13s |\n" "$user" "$system" "$idle"
  echo "+---------------------+-------------------+-----------------+"
echo
echo

}

# 5. Memory Usage
memory_usage() {
  # Get memory info
  read -r total used free <<< $(free -m | awk '/^Mem:/ {print $2, $3, $4}')
  read -r swapt swapsused swapsfree <<< $(free -m | awk '/^Swap:/ {print $2, $3, $4}')

  CYAN='\033[1;36m'
  BLUE='\033[1;34m'
  NC='\033[0m'

  echo "+------------------------------------------------------------+"
  echo -e "|   ${CYAN}MEMORY USAGE${NC}                                        |"
  echo "+----------------+----------------+---------------+"
  printf "| ${BLUE}Total (MB)${NC}       | ${BLUE}Used (MB)${NC}        | ${BLUE}Free (MB)${NC}       |\n"
  printf "| %-13s | %-14s | %-12s |\n" "$total" "$used" "$free"
  echo "+----------------+----------------+---------------+"
  printf "| ${BLUE}Swap Total:${NC} %-6s | ${BLUE}Used:${NC} %-6s | ${BLUE}Free:${NC} %-6s |\n" "$swapt" "$swapsused" "$swapsfree"
  echo "+------------------------------------------------------------+"
echo
echo

}



# 6. Process Monitoring
process_monitoring() {
  total=$(ps -e --no-headers | wc -l)
  echo "+------------------------------------------------------------+"

echo -e "|   ${CYAN}PROCESS MONITORING${NC}                 |"

  echo "+------------------------------------------------------------+"
 printf "| ${BLUE}Total Active Processes :${NC} ${BLUE}%-29s${NC} |\n" "$total"
  echo "+-----+----------------------+----------+"

printf "| %-3s | ${BLUE}%-20s${NC} | ${BLUE}%-8s${NC} |\n" "#" "Process Name" "CPU (%)"

  echo "+-----+----------------------+----------+"
  ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 | \
    awk '{printf "| %-3d | %-20s | %-8s |\n", NR, $2, $3}'
  echo "| ... | ...                  | ...      |"
  echo "+-----+----------------------+----------+"

printf "| %-3s | ${BLUE}%-20s${NC} | ${BLUE}%-8s${NC} |\n" "#" "Process Name" "MEM (%)"
  echo "+-----+----------------------+----------+"
  ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | \
    awk '{printf "| %-3d | %-20s | %-8s |\n", NR, $2, $3}'
  echo "| ... | ...                  | ...      |"
  echo "+-----+----------------------+----------+"
echo
echo

}

# 7. Service Monitoring
service_monitoring() {
  echo "+------------------------------------------------------------+"
  echo -e  "|  ${CYAN} SERVICE MONITORING  ${NC}                                   |"
  echo "+------------------------------------------------------------+"
  printf "| "
  for s in ssh nginx apache2 iptables ufw; do
    if systemctl is-active --quiet $s; then
      printf "%s:${GREEN}RUNNING${NC} | " "$s"
    else
      printf "%s:${RED}STOPPED${NC} | " "$s"
    fi
  done
  echo
  echo "+------------------------------------------------------------+"
echo
echo
}



# Full dashboard view
full_dashboard() {
  banner

  top_apps
  network_monitor
  disk_usage
  system_load
  memory_usage
  process_monitoring
 service_monitoring

 echo "+------------------------------------------------------------+"
  echo -e "| Press  ${CYAN}( CTRL + C )${NC} to ${CYAN} exit${NC} | Refresh every ${CYAN} ${INTERVAL}s${NC}           |"
  echo "+------------------------------------------------------------+"
}

# Custom switches
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -cpu) banner; system_load; exit ;;
    -memory) banner; memory_usage; exit ;;
    -network) banner; network_monitor; exit ;;
    -disk) banner; disk_usage; exit ;;
    -apps) banner; top_apps; exit ;;
    -proc) banner; process_monitoring; exit ;;
    -services) banner; service_monitoring; exit ;;
    -all) full_dashboard; exit ;;
    *) echo "Invalid option: $1"; exit 1 ;;
  esac
done

# Default behavior: run full dashboard in loop
while true; do
  full_dashboard
  sleep $INTERVAL
done
