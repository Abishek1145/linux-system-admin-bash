#! /bin/bash

create_user() {
        read -p "enter the username:" user
        if id "$user" &>/dev/null
        then
                echo "$user user exists"
        else
                echo "$user user doestn't exists creating it"
                sudo useradd -m -s /bin/bash "$user" &>/dev/null
                sudo passwd "$user"
                echo "$user user created successfully"
        fi
}


backup() {
        src=alpha
        dest=beta
        if [ -d $dest ]
        then
                echo "destination directory exist"
        else
                mkdir $src $dest
                cd $src
                touch a{1..5}.txt
                cd ..
        fi
        cp -r $src/* $dest
        if [ $? -eq 0 ]
        then
                echo "files copied successfully form $src to $dest directory"
        else
                echo "backup failed"
        fi
}

tools() {
        read -p "enter the tool name:" tool
        if which $tool &>/dev/null
        then
                echo "$tool tool exists"
        else
                echo "$tool tool doesn't exists, creating it "
                sudo apt update &>/dev/null
                sudo apt install  "$tool" -y &>/dev/null
                "$tool" --version
                echo "$tool tool installed successfully"
        fi
}

disk_usage() {
        disk=$(df -h | awk 'NR==14 {print $5}' )
        echo "current disk usage of C drive is $disk %"
}


echo "----------------------------------------------------------"
echo "menu display to automate task"
echo "1. create user"
echo "2. backup the files"
echo "3. installing tools"
echo "4. display current disk usage"
echo "----------------------------------------------------------"

read -p "enter user input: " choice

case $choice in
1) create_user ;;
2) backup  ;;
3) tools ;;
4) disk_usage ;;
*) echo "invalid choice"
esac