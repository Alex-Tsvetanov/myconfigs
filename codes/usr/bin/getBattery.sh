Status=`cat /sys/class/power_supply/BAT0/status`
Persents=`cat /sys/class/power_supply/BAT0/capacity`
echo "$Persents% $Status"
