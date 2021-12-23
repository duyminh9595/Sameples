# Supply Chain Management Using Hyperledger Fabric

## Blockchain Use Case Scenario based on "Hyperledger Fabric - v2.2.1"
### Supply Chain Management of Rubber

_Organizations: 5_
* Orderer Organization: 1
  * Fabric CA
    * Orderer1
    * Orderer2
    * Orderer3
* Peer Organization: 2
  * ThaySon (Exporter)
    * Fabric CA
      * 2 Peers (peer0 & peer1)
  * CoHuong (Exporter)
    * Fabric CA
      * 2 Peers (peer0 & peer1)



# update the OS
apt update && apt upgrade

# install some useful helpers
apt install tree jq gcc make

# it's always good the use the right time
# so setup the correct timezone
timedatectl set-timezone Asia/Ho-chi-minh

# check the time
date

Install Docker
# set up the repository
sudo apt install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

# add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -


# set up the stable repository
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

# install docker engine
apt update
apt install docker-ce docker-ce-cli containerd.io

# check the docker version
docker --version


# install docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# check the docker-compose version
docker-compose --version

# add PPA from NodeSource
curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh

# call the install script
. nodesource_setup.sh

# install node.js
apt-get install -y nodejs

# check the version
node -v

# install fabric
curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.2.1 1.4.9




