#!/usr/bin/expect
set ip [lindex $argv 0]
set user [lindex $argv 1]

spawn ssh $user@$ip
interact
