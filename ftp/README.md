#FTP Server
This is where you'll find everything done to the machine in order to setup de FTP server.

## Getting Started
You should be connected to your EC2 instance to make these modifications.

### Installing

First, update your system
```
sudo apt-get update
```
Install VSFTPD
```
sudo apt-get install vsftpd
```
Now we'll make our configuration saving the default as a backup
```
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.orig
```
It's important to remember that the firewall rules must be modified to allow connections to the FTP service.
The port 21 must be opened.


### Preparing the User Directory
 
We'll add a new user to handle the folder structure
```
sudo adduser zeh
```
Create the ftp folder
```
sudo mkdir /home/zeh/ftp
```
Set its ownership
```
sudo chown nobody:nogroup /home/zeh/ftp
```
Remove write permissions
```
sudo chown a-w /home/zeh/ftp
```
It's possible to verify the permissions running the following command
```
sudo ls -la /home/zeh/ftp
```
Now create the folder where the files would be uploaded
```
sudo mkdir /home/zeh/ftp/files
```
And assign the ownership to the user that we created
```
sudo chown zeh:zeh /home/zeh/ftp/files
```
You can check if permissions have changed by running
```
sudo ls -la /home/zeh/ftp
```
The last thing is to add a file to use as a test. We'll use a *test.txt* as example.
```
echo 'This is a test file' | sudo tee /home/zeh/ftp/files/test.txt
```

### Configuring FTP Access
This setup will allow a single user with a local shell account to connect with this FTP server.
In order to make this on our server, we have to modify two files.

The first one is vsftpd.conf. We shall uncomment the "write_enable" option in this file.
```
. . .
write_enable=YES
. . .
```
Uncomment the chroot too to prevent the FTP connected user from accessing any files or commands outside the directory.
```
...
chroot_local_user=YES
...
```
Now let's add "user_sub_token" and insert the username on "local_root directory" path to allow that every user of this machine would access the ftp.
```
user_sub_token=$USER
local_root=/home/$USER/ftp
```
At this point, we need to set the range of ports that FTP will use for its connections.
You can set any available range, of course. In this project, we set the ports 13000-13100 because we won't be using many connections.
Do not forget to add the rules on your firewall too.
```
passv_min_port=13000
passv_max_port=13100
```
Next, we'll tell to the server which users are allowed to connect, in a explicit way: Adding them on a list.
```
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
```
We can make this list a blacklist too, just changing the value of uselist_deny to **YES**. But here, we'll not do this.

So let's add our new user to this list
```
echo 'zeh' | sudo tee -a /etc/vsftpd.userlist
```
It's possible to check if the file was modified by running
```
cat /etc/vsftpd.userlist
```
Now, restart the service
```
sudo systemctl restart vsftpd
```
## Running the tests

### The server is working?
You can use the client "ftp" on linux systems to access the server (place your ip on the tag "<your_ip>").
```
ftp -p <your_ip>
```
This will prove that the server is up and running.
If your in an anonymous session or with users different than those we set, the server will prompt a message saying that he can't keep the connection.


To close the connection
```
ftp> bye
```

### How to visualize, download files?
You can go to the files directory that we created before
```
cd files
```
To list files
```
ls
```
To download files
```
get <filename>
```


## Built with
[VSFTPD](hhttps://security.appspot.com/vsftpd.html) - The FTP server

## Thanks to
*[Digital Ocean](http://www.digitalocean.com/) - for the [tutorial](https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-ubuntu-16-04).
