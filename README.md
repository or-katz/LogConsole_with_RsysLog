# LogConsole_with_RsysLog
tools for creating log of all the sessions in the console through SSH. everyting that "flows" in that console, whether it user input or system output will be written in that log. you can also use this tools for creating log of serial console for embedded devices or servers or some equipment that have console serial port. connect this devices to "serial to IP" devices like Moxa or use Raspberry Pi + ser2net + usb-serial dongle.

## instruction and preperations
install on the log server the following tools - <br>
Ubuntu/Debian:<br>
```
$ sudo apt update
$ sudo apt install tmux expect
```
Centos:<br>
```
$ sudo yum install tmux expect
```

## how to use
1. Download or clone the files in this project.
2. create conf file in rsyslog (change the name to whatever you want) - <br>
    ```
    sudo nano /etc/rsyslog.d/<log-conf-name>.conf
    ```
   with the following content (change user, group, log prefix, path to your system user and group and other preferences) - <br>
   ```
   $FileOwner <user>
   $FileCreateMode 0660
   $FileGroup <group>
   $template consoleLog, "<full_path>/log.log"
   if $msg contains 'log_prefix' then ?consoleLog
   & ~


   ```
3. save the file and restart rsyslog - <br>
   ```
   sudo systemctl restart rsyslog.service
   ```
4. edit the file ```run.sh``` and change the ```host``` and ```user``` to the machine that you want to connect through SSH.
   change ```log prefix``` to the exact prefix that you define in the rsyslog conf file.
5. run the ```run.sh``` script - 
   ```
   $ nohup ./run.sh &
   ```

