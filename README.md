Create a ec-2 instance and install terraform and ansible for configuration management and infrastructure management.
![image](https://github.com/user-attachments/assets/2a7b5357-49e7-49df-ab55-520b998db450)

<pre> terraform apply </pre>
Create a terraform file to create the rest of the machines, one should contain t2.medium with 2 cpus to configure kubernetes on it.
![image](https://github.com/user-attachments/assets/e8580fe0-499a-45c8-8131-fda0e41780de)

Now generate public keys and add them to rest of machines for the purpose of configuration management on rest of slave machines.
<pre>ssh-keygen</pre>
<pre>sudo cat id_rsa.pub</pre>
![image](https://github.com/user-attachments/assets/7992e4a7-cdf9-4a99-b654-ad620dfd495d)

Now try to ping the rest of the machines to check if they are added to the master machine.
<pre>ansible -m ping all</pre>
![image](https://github.com/user-attachments/assets/da31f9f4-ce0f-4a4c-ae03-927a5830df68)

Write ansible playbook to install jenkins and java on localhost which means on the current working instance and kubernetes on the rest of the machines.
![image](https://github.com/user-attachments/assets/df3bb745-3c3a-41f1-8311-18c7d2f61fb0)

Go to the Master node machine and initialize the kubernetes control plane.
<pre>sudo kubeadm init --pod-network-cidr=10.244.0.0/16</pre>
![image](https://github.com/user-attachments/assets/2030bc98-b218-4efa-a1dd-64ae3072c161)

Deploy the Flannel CNI (Container Network Interface) plugin in a Kubernetes cluster.
<pre>kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml</pre>
![image](https://github.com/user-attachments/assets/d61aabfa-e833-4707-bed2-663d615faded)

Now join the slave nodes to master nodes.
<pre> your-token --v=5
</pre>
![image](https://github.com/user-attachments/assets/560e71f2-19ba-4871-8e9f-18b6492d30bb)

Worker nodes are connected to the master plane.
<pre>kubectl get nodes</pre>
![image](https://github.com/user-attachments/assets/13f1b427-6351-4c54-a7e8-c4e2226d3a08)

Install docker on master plane.
Unhold the packages if any of them were on hold.
<pre> dpkg --get-selections | grep hold
sudo apt-mark unhold kubeadm
sudo apt-mark unhold kubectl
sudo apt-mark unhold kubelet 
</pre>
![image](https://github.com/user-attachments/assets/a63068da-2ad6-485d-8f02-75de4d425a9a)

Also remove conflits on container.io
<pre>sudo apt-get remove --purge containerd</pre>
![image](https://github.com/user-attachments/assets/65246bb9-4192-470d-888c-a0c42692d439)

<pre>sudo apt-get install containered.io</pre>
![image](https://github.com/user-attachments/assets/1b65fecb-0a52-4f8f-a329-a237abe43977)

Now Configure jenkins by adding the slave node to it.
![image](https://github.com/user-attachments/assets/78a28261-e117-46c8-874e-6bbb03c34e01)

Create a Jenkins pipeline by adding the docker hub credentials and
source code location.

● Docker commands to run and build images and push images to the
central docker hub.

● Configure the kubernetes service and yaml.

![image](https://github.com/user-attachments/assets/59cd0e02-1b2d-467f-b129-124c2e7e7915)

Build the pipeline.
![image](https://github.com/user-attachments/assets/878927b7-a473-46fe-8f2c-ffc3eb66b89a)


You can access the source code on jenkins slave machine.
![image](https://github.com/user-attachments/assets/275ff85e-39d0-4ea3-8170-32bcebcf43e0)

Docker image is pushed into central docker hub.

![image](https://github.com/user-attachments/assets/d412e0b1-abfb-4f18-919d-0f3dc959fe9f)
