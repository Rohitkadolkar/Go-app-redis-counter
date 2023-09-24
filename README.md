# Go-app-redis-counter

# DevOps Task

This repository contains the implementation of a DevOps task, including the setup of a Go application with Docker and Docker Compose, Vagrant provisioning with Ansible, and additional configurations.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- [Go](https://golang.org/doc/install) installed for building the Go application.
- [Docker](https://docs.docker.com/get-docker/) installed for containerization.
- [Docker Compose](https://docs.docker.com/compose/install/) installed for orchestrating containers.

## Project Structure

Please make sure all the given files in this repository are cloned in a single repository for tools to setup.

## Setup Instructions

### Docker Compose
```
docker-compose up -d
```
You can verify that the services are running using 
```
docker -ps
```
### Vagrant and Ansible
You will need sudo permissions to run the script as there are several commands that require administrative permissions (superuser or sudo privileges) to execute successfully.
Run the Vagrant setup script to create and provision a VM:
```
sudo chmod +x setup_vagrant.sh
sudo ./setup_vagrant.sh
```
You will need to use sudo with vagrant commands as well because we have created vagrant using user sudo.

Once Vagrant is setup, it will already be up as it is included in the script.
Open Vagrantfile and make changes so that configuration looks something like this :
```
Vagrant.configure("2") do |config|

config.vm.box = "ubuntu/bionic64"

config.vm.network "forwarded_port", guest: 80, host: 80

config.vm.provision "ansible" do |ansible|

  ansible.playbook = "provision.yml"
  
end
```
Once done perform:
```
sudo vagrant halt
```
Then,
```
sudo vagrant up
```
This will add network configurations and add ansible configuration playbook

In case you need to ssh into Vagrant virtualbox use:
```
sudo vagrant ssh
```
Now to provision ansible using ansible playbook, use:
```
sudo vagrant provision
```
This will provision the vagrant box using ansible

### Ansible is used to provision the VM with the following configurations:

* Hostname: demo-ops

* User: demo

*Security:

   * Disable root login.
   
   * Set up a basic firewall (UFW) allowing only specific ports.
   
* Configure sysctl parameters for better performance.

   * Configure sysctl for sane defaults. (For eg: increasing open files limit)
   
   * Configure sysctl for sane defaults. For each sysctl parameter changed:
   
   * Document the change. 
   
   * Justification -
   
    Increasing the fs.file-max parameter helps to raise the limit of open files for processes, which can be helpful for applications that need to handle many simultaneous connections or files.
    The change ensures that the system can handle a larger number of open files, improving the scalability and performance of applications like Redis and Nginx. 
        
* Set the system's timezone to "Asia/Kolkata".

* Install Docker and Docker Compose.

* Configure Docker Daemon with sane defaults.

* Deploy the Docker Compose file to /etc/demo-ops and start the services.



Now to access it, Go to your browser and type http://localhost 

You can reload the page and see the Redis counter increasing.


Thank you! PLease feel free to reach out to me if you face any issues.



