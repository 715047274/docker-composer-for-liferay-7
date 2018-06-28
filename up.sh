# Address max_map_count
# https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html
sudo sysctl -w vm.max_map_count=262144 || true

sudo docker-compose up -d
