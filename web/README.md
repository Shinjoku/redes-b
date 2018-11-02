# Web Server
This is where you'll find everything done to the machine in order to setup de web server.

## Getting Started
You should be connected to your EC2 instance to make these modifications.

### Installing

First, update your system
```
sudo apt-get update

```
Install Apache (type Y and hit enter when asked)
```
sudo apt-get install apache2
```
Make sure that Apache is running with our mode rewrites
```
sudo a2enmod rewrite
```
Install PHP to run all files inside apache
```
sudo apt-get install php libapache2-mod-php
```

### Changing Default Folder
We can change the default dir that apache will look for files.
You can do this by opening the file
```
/etc/apache2/sites-enabled/000-default.conf
```
And paste the following code in the end of the file's content
```
<Directory /var/www/>
	Options Indexes FollowSymLinks MultiViews
	# changed from None to FileInfo
	AllowOverride FileInfo
	AllowOverride All
	Order allow,deny
	allow from all
</Directory>
```
Now your root folder is */var/www/*.
To manage the folder, we'll have to change its permitions to allow our user to modify the files.
```
sudo adduser ubuntu www-data
```
Now we're going to grant user access permissions to view and edit
```
sudo chown -R www-data:www-data /var/www
sudo chmod -R g+rw /var/www
```
Now, let's restart apache2 to run the changes
```
sudo service apache2 restart
```


### Running The Server
After installing, the server will be up.
Now you have to **open the port 80** in order to allow access from other computers.
If you're using a EC2 instance, you can do it from the firewall page, simply adding a rule.


## Running the tests

### The server is working?
You can use your browser to visit your IP. It should load the default page from Apache.


### How to change this page?
Add/Update the files that are contained in the default folder. If you add a folder, simply navigate to it, using the URL on the browser just like an path from a file explorer.

## Built with
[Apache](https://www.apache.org/) - The web server

## Thanks to
*[KvCodes](http://www.kvcodes.com/) - for the [tutorial](http://www.kvcodes.com/2017/05/install-apache-aws-ubuntu/).
