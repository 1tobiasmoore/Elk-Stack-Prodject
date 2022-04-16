# Elk-Stack-Project
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![TODO: Update the path with the name of your diagram](Images/diagram_filename.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Configuration and YAML file may be used to install only certain pieces of it, such as Filebeat.

  - _TODO: Enter the playbook file._

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- _TODO: What aspect of security do load balancers protect? Implementation of a load balancer to the network will add a layer of security and help mitigate the risk of a DDoS attack. What is the advantage of a jump box?_

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.
- _TODO: What does Filebeat watch for?_ Filebeat will collect log events and gather data about the file system.
- _TODO: What does Metricbeat record?_ Metricbeat is used to monitor and collect metrics from the system services running on each server.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Jump Box Provisioner | GateWay                                   | 10.0.0.4      | Linux                     |
|----------------------|-------------------------------------------|---------------|---------------------------|
| Local Machine       | Configurating network externally          | 73.237.129.7  | Mac OS High Sierra  10.13 |
| Web-1 VM             | Process and deliver web content to user   | 10.0.0.9      | Linux                     |
| Web-2 VM             | Process and deliver web content to user   | 10.0.0.6      | Linux                     |
| Web-3 VM             | Process and deliver web content to user   | 10.0.0.7      | Linux                     |
| ELK-Server           | Collect and process data from Web VMs     | 10.1.0.5      | Linux                     |
| Load Balancer        | Distribute Traffic to backend server pool | 20.124.230.45 | n/a                       |
### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- _TODO: Local Workstation with public IP address of  73.237.129.7 has been whitelisted. This machine has the ability to access the Jump Box via SSH through port 22

Machines within the network can only be accessed by _Jump Provisioner____.
- _TODO: Which machine did you allow to access your ELK VM? What was its IP address?_ Local Machine public IP 73.237.129.7 through port 22

A summary of the access policies in place can be found in the table below.

| Name         | Publicly Accessible | Allowed IP Addresses                               |
|--------------|---------------------|----------------------------------------------------|
| Jump Box     | yes                 | 73.237.129.7 via port 22                           |
| Web-1 VM     | no                  | 10.0.0.4 via SSH port 22                           |
| Web-2 VM     | no                  | 10.0.0.4 via SSH port 22                           |
| Web-3 VM     | no                  | 10.0.0.4 via SSH port 22                           |
| Elk-Server   | 5601 only           | Local Machine 73.237.129.7 via port 5601, 10.0.0.4 |
| Load Balance | yes                 | Local Machine 73.237.129.7 via HTTP port 80        |
### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- _TODO: What is the main advantage of automating configuration with Ansible?_ With Ansible it allows one to create and configure several machines at the same time.
It also allows for the machines to be deploy the same script to ensure that all machines are identical. 

The playbook implements the following tasks:
- _TODO: In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._

The first step in the playbook specifies the remote user as RedAdmin and indicates that the hosts in the “elk” group of machines will be configured.  
- name: Configure Elk VM with Docker
    hosts: elk
    remote_user: admi
    become: true
    tasks:

The playbook then was configured to install the Docker engine used to run containers, called docker.io.
      # Use apt module
    - name: Install docker.io
      apt:
        update_cache: yes
        name: docker.io
        state: present  

In the third step, the python3-pip package was installed, which is used to run Python software.
       # Use apt module
     - name: Install pip3
       apt:
         force_apt_get: yes
         name: python3-pip
         state: present

In the next step the playbook will specify the installation of this Docker Python module.
       # Use pip module
     - name: Install Docker python module
       pip:
         name: docker
         state: present

The next step in the playbook will help ensure the ELK server utilizes the proper amount of memory required to run.
       # Use sysctl module
     - name: Use more memory
       sysctl:
         name: vm.max_map_count
         value: "262144"
         state: present
         reload: yes


The playbook will be configured to install the ELK Docker container called sebp/elk:761.
       # Use docker container module
       name: download and launch a docker elk container
       docker_container:
         name: elk
         image: sebp/elk:761
         state: started
         restart_policy: always



In the final step of the playbook the port mappings will be defined.
        published_ports:
           - 5601:5601
           - 9200:9200
           - 5044:5044

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _TODO: List the IP addresses of the machines you are monitoring

Web-1 VM: 10.0.0.9
Web-2 VM: 10.0.0.6 
Web-3 VM: 10.0.0.7 

We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_

Filebeat
Metricbeat

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._
 Metricbeat reports on the health of a system and collects various machine metrics such as uptime, memory usage, and Network IO.
Filebeat collects and aggregates various log events regarding the file systems on a host. 

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-config.yml file to /etc/ansible/files/filebeat-config.yml..
- Update the  filebeat-config.yml file to include the installation path, username/password, the IP address of the ELK server under outpout.elasticsearch within the configuration file, and the IP address and port number under the setup.kibana field.

- Run the playbook, and navigate to http://:5601/app/kibana to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_  filebeat-playbook.yml. It will be copied in the /etc/ansible/roles/filebeat-playbook.yml directory.

- _Which file do you update to make Ansible run the playbook on a specific machine? Using the Ansible Host file will initiate the playbook to run on a specific machine. How do I specify which machine to install the ELK server on versus which to install Filebeat on?_Under the "web servers" group I listed which VMs would be configured with Filebeat. Also created an "elk" group to specify the VM that will be configured with the ELK server.  _Which URL do you navigate to in order to check that the ELK server is running? 73.237.129.7:5601/app/kibana
_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
