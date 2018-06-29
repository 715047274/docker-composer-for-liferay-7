docker-compose down --volumes

sudo rm -rf elasticsearch/data/*
sudo rm -rf elasticsearch/logs/*
sudo chmod 777 -R elasticsearch/* -R

sudo rm -rf mysql/data/*
sudo chmod 777 mysql/* -R

sudo rm -rf solr/logs/*
sudo rm -rf solr/liferay/data/*
sudo chmod 777 solr/* -R
