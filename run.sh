#!/bin/bash

set $host=host
set $user=user



touch console

if ps -ef |grep "[t]mux new-session -d -s $USER $(pwd)/connectToConsole.sh" > /dev/null
then
	kill -9 $(ps aux |grep "[t]mux new-session -d -s $USER $(pwd)/connectToConsole.sh" |awk '{print $2}')
fi







tmux new-session -d -s "$USER" "$(pwd)/connectToConsole.sh $host $user |tee -i -a $(pwd)/console" &
tail -f -n 1 $(pwd)/console |while read log; do logger "console_log - $log"; done &

while true >> /dev/null ; do
	sleep 5
	sed -i -n '$p' $(pwd)/console &
	if ! ps -ef |grep "[t]mux new-session -d -s $USER $(pwd)/connectToConsole.sh" > /dev/null
		then
		tmux new-session -d -s "$USER" "$(pwd)/connectToConsole.sh raspberrypi pi |tee -i -a $(pwd)/console" &
		tail -f -n 1 $(pwd)/console |while read log; do logger "console_log - $log"; done &
	fi
		
done 
