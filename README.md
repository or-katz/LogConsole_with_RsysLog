# LogConsole_with_RsysLog
tools for creating log of all the sessions in the console through SSH. everyting that "flows" in that console, whether it user input or system output will be written in that log. you can also use this tools for creating log of serial console for embedded devices or servers or some equipment that have console serial port. connect this devices to "serial to IP" devices like Moxa or use Raspberry Pi + ser2net + usb-serial dongle.

## instruction and preperations
install on the log server the following tools -
Ubuntu/Debian:
```
$ sudo apt update
$ sudo apt install tmux expect
```
Centos:
```
$ sudo yum install tmux expect
```

## how to use
1. Download or clone the files in this project.
2. create conf file in rsyslog (change the name to whatever you want) - <br>
    ```
    sudo nano /etc/rsyslog.d/<log-conf-name>.conf
    ```
   with the following content (change user, group, path to your system user and group and other preferences) -
   Ubuntu/Debian:
   ```
   $PrivDropToUser <user>
   $PrivDropToGroup <group>
   :msg,contains,"console_log" <ful_path>/log.log
   ```
   Centos:
   ```
   $FileOwner or
   $FileCreateMode 0660
   $FileGroup or
   $template consoleLog, "/home/or/log.log"
   if $msg contains 'console_log' then ?consoleLog
   & ~
   ```
3. save the file and restart rsyslog -
   ```
   sudo systemctl restart rsyslog.service
   ```
4. edit the file ```run.sh``` and change the ```host``` and ```user``` to the machine that you want to connect through SSH and log the entire console.
5. run the ```run.sh``` script - 
   ```
   $ nohup ./run.sh &
   ```
6. attach to console by ```tmux attach-session -t "$USER"```

