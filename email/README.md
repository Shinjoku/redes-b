# DNS cache
This is where you'll find everything done to the machine in order to setup the E-mail Server.

## Getting Started
You should be connected to your EC2 instance to make these modifications.


### Installing

First, update your system
```
sudo apt-get update
```
Install Postfix
```
sudo apt-get install postfix
```

While installing, you can be prompt to answer some questions to setup the environment. We used the following settings:
```
General type of mail configuration: Internet Site
System mail name: clausenezerbetto.com
Root and postmaster mail recipient: ubuntu
Other destinations to accept mail for: clausenezerbetto.com, smtp.clausenezerbetto.com, localhost
Force synchronous updates on mail queue: No
Local networks: 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
Mailbox size limit: 0
Local address extension character: +
Internet protocols to use: all
```
We used these addresses (clausenezerbetto.com and smtp.clausenezerbetto.com) because we already set our domain name inside our DNS server.


### Setup the Postfix Configuration
let's set the mailbox directory
```
sudo postconf -e 'home_mailbox= Maildir/'
```
Then, we'll set the location of the table that will contain all email accounts from linux system accounts
```
sudo postconf -e 'virtual_alias_maps= hash:/etc/postfix/virtual'
```

### Map Mail Addresses to Linux Accounts
Now we'll bind the email in the list to our user account "ubuntu"

#### On /etc/postfix/virtual

Add your new email account and the linux user account that is binded to this email
```
 ubuntu@clausenezerbetto.com ubuntu
```
Now, we restart the service
```
sudo systemctl restart postfix
```


### Adjust the Firewall!

We need to open the port **25** in order to make the server completely work.

We did this with the security pannel, in the EC2 page. But, if you're not using an EC2 instance, type this and everything should be ok
```
sudo ufw allow Postfix
```


### Setting up the Environment to Match the Mail Location

Right now, what we really need is a Email client to send some emails. But, in order to have one, we need to set the MAIL environment variable. Once this variable is defined, we can procceed to the next step

So, let's create this variable
```
echo 'export MAIL=~/Maildir' | sudo tee -a /etc/bash.bashrc | sudo tee -a /etc/profile.d/mail.sh
```
To read this new variable into our current session
```
source /etc/profile.d/mail.sh
```


### Install the Client

We can use any client, but here we used s-nail. To install this client, type
```
sudo apt-get install s-nail
```
And we need to add the options for s-nail allow us to open even with a empty box, set our default folder as the Maildir that we created before and use this to create a sent box too.
```
set emptystart
set folder=Maildir
set record=+sent
```
Don't forget to save before closing the file!

## Initialize the Maildir and Test the Client

Probably, you'll be able to initialize this directory sending an email with the following line
```
echo 'Message that you want, it can be anything' | mail -s 'Subject!' -Snorecord ubuntu@clausenezerbetto.com
```
But we had some problems with the argument -Snorecord. If you have it too, simply type the same command as above, but withou this argument. It shouild be like this
```
echo 'Message that you want, it can be anything' | mail -s 'Subject!' ubuntu@clausenezerbetto.com
```
You can check the directories typing
```
ls -R ~/Maildir
```

## Running the tests

### The service is working?
Now we can use the mail program to see our box
```
mail
````
There must be a email listed as new. To check it, hit enter.

Now, you can go back to the mail **home**
```
? h
```
to delete this email
```
? d
```
And to exit the mail program
```
? q
```
And that's it!


## Built with
[Postfix](http://www.postfix.org/) - The E-mail Server.

## Thanks to
*[Digital Ocean](http://www.digitalocean.com/) - for the [tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postfix-on-ubuntu-16-04).
