#!/bin/sh
clear


user=$(whoami)
host=$(uname -n)
os=$(uname -s)
kernel=$(uname -r)
uptime=$(uptime | awk '{print $3,$4}' | sed 's/,//')
shell="$SHELL"
cpu_arch=$(uname -p)
cpu_model=$(uname -m)


calculate_memory() {
    local meminfo="/tmp/meminfo"
    local total_mem=0
    local free_mem=0

    
    if [ -f "$meminfo" ]; then
        total_mem=$(awk '/MemTotal/ {print $2}' "$meminfo")
        free_mem=$(awk '/MemAvailable/ {print $2}' "$meminfo")
        rm "$meminfo"
    fi

  
    total_mem=$(format_bytes "$total_mem")
    free_mem=$(format_bytes "$free_mem")

    echo "$total_mem"
    echo "$free_mem"
}


format_bytes() {
    local bytes=$1
    local unit="B"

    if [ $bytes -gt 1024 ]; then
        bytes=$((bytes / 1024))
        unit="KB"
    fi

    if [ $bytes -gt 1024 ]; then
        bytes=$((bytes / 1024))
        unit="MB"
    fi

    if [ $bytes -gt 1024 ]; then
        bytes=$((bytes / 1024))
        unit="GB"
    fi

    echo "$bytes $unit"
}


total_memory=$(calculate_memory)




cat << "EOF"
                    ,xNMM.
               .OMMMMo
               lMM"
     .;loddo:.  .olloddol;.
   cKMMMMMMMMMMNWMMMMMMMMMM0:
${c2} .KMMMMMMMMMMMMMMMMMMMMMMMWd.
 XMMMMMMMMMMMMMMMMMMMMMMMX.
${c3};MMMMMMMMMMMMMMMMMMMMMMMM:
:MMMMMMMMMMMMMMMMMMMMMMMM:
${c4}.MMMMMMMMMMMMMMMMMMMMMMMMX.
 kMMMMMMMMMMMMMMMMMMMMMMMMWd.
 ${c5}'XMMMMMMMMMMMMMMMMMMMMMMMMMMk
  'XMMMMMMMMMMMMMMMMMMMMMMMMK.
    ${c6}kMMMMMMMMMMMMMMMMMMMMMMd
     ;KMMMMMMMWXXWMMMMMMMk.
       "cooc*"    "*coo'"

EOF


echo "User:                  $user"
echo "Host:                  $host"
echo "OS:                    $os"
echo "Kernel:                $kernel"
echo "Uptime:                $uptime"
echo "Shell:                 $shell"
echo "CPU Architecture:      $cpu_arch"
echo "CPU Model:             $cpu_model"
echo "Total Memory:          $total_memory"
