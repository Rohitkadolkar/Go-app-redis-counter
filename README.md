<<<<<<< HEAD
<<<<<<< HEAD
# Go-app-redis-counter

# DevOps Task

This repository contains the implementation of a DevOps task, including the setup of a Go application with Docker and Docker Compose, Vagrant provisioning with Ansible, and additional configurations.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- [Go](https://golang.org/doc/install) installed for building the Go application.
- [Docker](https://docs.docker.com/get-docker/) installed for containerization.
- [Docker Compose](https://docs.docker.com/compose/install/) installed for orchestrating containers.
- [Vagrant](https://www.vagrantup.com/docs/installation) installed for creating a virtual machine.
- A virtualization provider like [VirtualBox](https://www.virtualbox.org/) installed (needed for Vagrant).

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
Open Vagrantfile and add the following configurations :
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





=======
# Zerodha Ops Task
=======
# Ops Task
>>>>>>> d33db98 (Update README.md)

## Description

This is a sample `Go` application which connects to Redis. The app increments a Redis `counter` on an incoming request.

### Setting up the app

- Use `make build` to compile the binary.
- Set the environment variables:
  - `DEMO_APP_ADDR`: Address where the app should listen to
  - `DEMO_REDIS_ADDR`: Address where Redis is running

## Tasks

- Create a `Dockerfile` for the app.

- Create a `docker-compose.yml` for the app which includes the following:
  - `redis` service, with data directory mounted.
  - `app` service, ensuring that it has a dependency on the Redis service starting correctly.
  - `nginx` service acting as a reverse proxy for the app. Bonus: Implement SSL using self-signed certificates.

- Write a bash script to set up a [Vagrant box](https://vagrant.io) with Ubuntu. Ensure the script has error checks and is idempotent.

- Using Ansible provision the VM to:
  - Setup hostname of VM as `demo-ops`.
  - Create a user `demo`.
  - Harden the security:
    - Disable root login.
    - Setup a basic firewall (e.g., UFW) allowing only specific ports.
  - Configure `sysctl` for sane defaults. (For eg: increasing open files limit)
  - Configure sysctl for sane defaults. For each sysctl parameter changed:
    - Document the change.
    - Provide a brief justification or explanation (2-3 lines) detailing why this specific change was made and its implications.
  - Set the system's timezone to "Asia/Kolkata".
  - Install Docker and Docker-Compose.
  - Configure Docker Daemon to have sane defaults. For eg: keep logs size in check.
  - Deploy the `docker-compose.yml` in `/etc/demo-ops` and start the services.
  - Bonus: Install and configure monitoring tools like Prometheus and Grafana. Ensure app and redis metrics are being scraped.

- Commit the scripts to Github and share the link.

### Bonus Section

If you have extra time and experience working with Kubernetes or Nomad, you're welcome to attempt the following bonus scenarios. Remember, this section is optional and designed to explore advanced skills.

#### K8s

- Create a namespace `demo-ops`
- Create a deployment and service manifest for the app.
- Configure liveliness check, resource quotas for the deployment.

#### Nomad
  - Create a namespace `demo-ops`
  - Create a Job spec for the app. You can group both the services (`app` and `redis`) under the same job.
  - Run on a local Nomad dev agent.
>>>>>>> d6b7880 (Add files via upload)
