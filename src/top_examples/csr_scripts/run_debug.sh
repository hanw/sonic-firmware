#!/bin/sh
export QUARTUS_HOME=/home/hwang/altera/11.0/quartus
export SYSTEM_CONSOLE_PATH=/sopc_builder/bin/
export SYS_CONSOLE_SCRIPT_PATH=.

echo "################################################################"
echo "       Launching Altera system-console..."
echo "Usage: "
echo "  0. Type 'usage' to repeat this message"
echo "  1. Type 'source init' to load all debug routines"
echo "  2. Type 'config' to set Netlogic to operating mode"
echo "  3. Type 'lpbk 1' to set Netlogic PMA into loopback mode"
echo "  4. Type 'lpbk 0' to unset Netlogic PMA from loopback mode"
echo "  5. Type 'stats' to list the current status of the system"
echo "################################################################"
$QUARTUS_HOME/$SYSTEM_CONSOLE_PATH/system-console -cli
