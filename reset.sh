docker-compose down --volumes

sudo rm -rf elasticsearch/data
mkdir elasticsearch/data
sudo chmod 777 -R elasticsearch

sudo rm -rf mysql/data
mkdir mysql/data
sudo chmod 777 mysql -R
