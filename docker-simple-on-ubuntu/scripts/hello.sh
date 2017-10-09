#!/bin/bash

echo 'hello'

export AZURE_STORAGE_ACCOUNT=$2
export AZURE_STORAGE_ACCESS_KEY=$1

wget https://raw.githubusercontent.com/Azure/azurefile-dockervolumedriver/master/contrib/init/systemd/azurefile-dockervolumedriver.default
sudo wget https://raw.githubusercontent.com/Azure/azurefile-dockervolumedriver/master/contrib/init/systemd/azurefile-dockervolumedriver.service
sudo wget -qO/usr/bin/azurefile-dockervolumedriver https://github.com/Azure/azurefile-dockervolumedriver/releases/download/v0.5.1/azurefile-dockervolumedriver
sudo chmod +x /usr/bin/azurefile-dockervolumedriver
sudo mv azurefile-dockervolumedriver.default /etc/default/azurefile-dockervolumedriver
sudo sed -i "s/AZURE_STORAGE_ACCOUNT=youraccount/AZURE_STORAGE_ACCOUNT="$AZURE_STORAGE_ACCOUNT"/g" "/etc/default/azurefile-dockervolumedriver"
sudo sed -i "s,AZURE_STORAGE_ACCOUNT_KEY=yourkey,AZURE_STORAGE_ACCOUNT_KEY="$AZURE_STORAGE_ACCESS_KEY",g" "/etc/default/azurefile-dockervolumedriver"
sudo mv azurefile-dockervolumedriver.service /etc/systemd/system/azurefile-dockervolumedriver.service
sudo systemctl daemon-reload
sudo systemctl enable azurefile-dockervolumedriver
sudo systemctl start azurefile-dockervolumedriver


azure storage directory create $AZURE_STORAGE_ACCOUNT nodered-flows
azure storage directory create $AZURE_STORAGE_ACCOUNT geth-data
azure storage directory create $AZURE_STORAGE_ACCOUNT geth-data/testnet
azure storage directory create $AZURE_STORAGE_ACCOUNT redis-data
azure storage directory create $AZURE_STORAGE_ACCOUNT rethinkdb-data
azure storage directory create $AZURE_STORAGE_ACCOUNT apphero-data
azure storage directory create $AZURE_STORAGE_ACCOUNT apphero-data/log
azure storage directory create $AZURE_STORAGE_ACCOUNT couchdb-data
azure storage directory create $AZURE_STORAGE_ACCOUNT logstash-config