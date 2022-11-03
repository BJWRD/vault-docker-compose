# vault-docker-compose
[Hashicorp Vault](https://developer.hashicorp.com/vault) application, built by [Dockerfile](https://docs.docker.com/engine/reference/builder/), provisioned via [Docker-Compose](https://docs.docker.com/compose/install/) and hosted within a [Docker](https://www.docker.com/) container.

# Architecture

![image](https://user-images.githubusercontent.com/83971386/199697106-a69aba09-21f6-435b-987f-cdcdba2273da.png)

# Prerequisites
* Virtual Machine - Virtualbox installation - [steps](https://www.virtualbox.org/)

# How to Apply/Destroy
This section details the deployment and teardown of the architecture.

### Docker Container Deployment Steps

#### 1.  On the provisioned VM - Clone the repo
     sudo yum install git -y 
     cd /home
     git clone https://github.com/BJWRD/vault-docker-compose

#### 2.  Execute the install.sh script
     cd vault-docker-compose
     sudo chmod 700 install.sh
     sudo ./install.sh
     
Note: The Bash script may take up to 5 minutes to finish and complete it's software installations/updates.

#### 3.  Move the Vault executable to the relevant directory

     sudo mv /usr/bin/vault /home/vault-docker-compose/

#### 4.  Running Vault Container
Enter the following Docker-Compose command to start the Vault container in detatched mode.

    docker-compose up -d
    docker ps
    
<img width="565" alt="image" src="https://user-images.githubusercontent.com/83971386/199185616-9103031f-7577-4bc9-9dd0-59c99b403f58.png">

Note: In the instance that the container has failed to run due to the Dockerfile Entrypoint config, then comment out the Entrypoint line within the Dockerfile and enter the commands below -

    docker-compose up -d
    docker ps 
    docker exec -it <container ID> bash
    vault server -config=/home/vault/config/config.hcl
    
<img width="564" alt="image" src="https://user-images.githubusercontent.com/83971386/199185774-077b2535-3883-4ce2-84a6-a50bea52e76a.png">
    
### Vault Setup

#### 1.  Vault Initialisation 

Now that we have a running instance, we now need to initialise Vault.

First access the Container running Vault -

    docker ps 
    docker exec -it <container ID> bash   
     
Then enter the following two commands (you will need to set the VAULT_ADDR envrionment variable accordingly to your VM IP Address) -

    export VAULT_ADDR='http://<VM IP Address>:8080'
    vault operator init

<img width="556" alt="image" src="https://user-images.githubusercontent.com/83971386/199186152-4d9e1f36-9813-45ae-8a31-1bdfcf2740e1.png">

The initialisation outputs two incredibly important pieces of information: the *unseal keys* and the initial *root token*. This is the only time ever that all of this data is known by Vault, and also the only time that the unseal keys should ever be so close together.

Save all of these keys somewhere secure, and continue.

#### 2.  Vault Seal/Unseal

Every initialized Vault server starts in the sealed state. Unsealing has to happen every time Vault starts and it can be done via the command line. 

To unseal the Vault, you must use three of the outputted unseal keys generated at initialisation. 

    vault operator unseal
     
Once the three unseal keys have been entered, you will see a screen similar to the one below -

<img width="435" alt="image" src="https://user-images.githubusercontent.com/83971386/199186318-315f3a2a-1a6f-4856-ba92-e9d50d63fff6.png">

When the value for Sealed changes to false, the Vault is unsealed. As a root user, you can reseal the Vault with *vault operator seal*.

#### 3.  Vault Login

Finally, authenticate as the initial root token

    vault login
     
<img width="526" alt="image" src="https://user-images.githubusercontent.com/83971386/199186402-d117f878-5274-4e74-8598-0b12da071599.png">

### Accessing the Vault Web UI

#### 1.  Access via the Web Browser

Launch a web browser, and enter http://(VM IP Address):8080/ui in the address bar.

Then login with the root token (generated at initialisation) -

<img width="1154" alt="image" src="https://user-images.githubusercontent.com/83971386/199186462-36b93abc-3b8f-4a0a-bcb8-c21e164d6451.png">

#### 2.  Vault Authentication Methods

Now that we have a running Vault system, you may want to use different authentication methods other than *root token* authentication. 

This can be achieved via the *Access* screen within the Vault User Interface -

<img width="1153" alt="image" src="https://user-images.githubusercontent.com/83971386/199186544-2ee4b770-9b2f-45a3-a5ea-c8f4e7bd2307.png">

More on this can be found within the following site - 

https://developer.hashicorp.com/vault/docs/auth

#### 3.  Creating Secrets

We are also now in the positon whereby we are able to enter our secrets securely within the Vault -

<img width="1143" alt="image" src="https://user-images.githubusercontent.com/83971386/199186607-6d2b2c0d-aa13-4c2f-be7c-0d93c0ba5162.png">

Once again, more information can be found at the following site - 

https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-first-secret

### Teardown steps

#### 1.  Stop the Docker Container which is running Vault

    docker-compose down
    
# List of tools/services used
* [Docker](https://www.docker.com/)
* [Dockerfile](https://docs.docker.com/engine/reference/builder/)
* [Docker-Compose](https://docs.docker.com/compose/install/)
* [Hashicorp Vault](https://developer.hashicorp.com/vault)
