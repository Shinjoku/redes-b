# Redes B Project 1

Here you'll find the projects from the discipline of Computer's Network, from PUC-Campinas.
All these projects were developed by Shinjoku and luizerbetto, both students of the university.
Of course, this would not be possible without or teacher and the help of the network tutorials (carefully googled).

In this project, our goal was create an enterprise environment, counting with the following services:
  - Web;
  - FTP;
  - DNS;
  - Email.
  
 We used a EC2 machine, provided by AWS, running Ubuntu 18.04.


## Getting Started

This project is not mean to be "executed". It conly contains descriptions and files that were used/modified in the proccess of making the enterprise environment. Even though, there are some core packages that were used to build and run those applications. You can find the description of these applications in the readme of each service.

But, to edit all the files without an graphical interface, we used VIM.
```
sudo apt-get install vim
```


### Prerequisites

Each technology has it's restrictions, but the core thing is a linux-based system running on a machine. It doesn't need to be a strong machine. As example, we're using a AWS EC2 from the free plan. It's a very limited scenario, but these services runs as smooth as they could be.

```
Linux-based OS
```

## Running the tests

The tests will be explained inside each service. But, if you want to get ready soon, it's good to have:
  - nslookup;
  - Browser of your choice;
  - mailutils;
  - FTP client of your choice.
  

## Authors

* **José Carlos Clausen Neto** - *Changes, setup and documentation* - [Shinjoku](https://github.com/Shinjoku)
* **Luiz Felipe Zerbetto Masson** - *Changes, setup and documentation* - [luizerbetto](https://github.com/luizerbetto)


## Acknowledgments

* [PurpleBooth](https://github.com/PurpleBooth) for [this readme base](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
* Our teacher for the patience and all the explanations that made this possible.
* [FTP Server Tutorial, by DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-ubuntu-16-04)
* [Web Server Tutorial, by KvCodes](http://www.kvcodes.com/2017/05/install-apache-aws-ubuntu/)
* [DNS Service Tutorial, by DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-private-network-dns-server-on-ubuntu-14-04)
* [Email Server Tutorial, by DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postfix-on-ubuntu-16-04)
