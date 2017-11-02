# elasticsearch-docker-composer-for-liferay-7
This is for setting up docker-composer to test Elasticsearch and Kuromoji against Liferay 7 GA4 / DXP de32 (Elasticsearch 2.4)

## Required environment
- Docker 17.06.2-ce >=
- Java8

## How to set up
1. Clone this repository
2. Go to /es/config/elasticsearch.yml and configure network.publish_host to the address where this docker images run. If it's your local machine, should be ```"192.168.1.4"``` e.g.
3. Go back to the root folder and run ```docker-compose up --build```
4. Start Liferay DXP / 7
5. Login as an administrator and navigate to Control Panel -> Configuration -> System Setting -> Basic configuration tab -> Elasticsearch
6. Change Operation mode to REMOTE and Transport addresses to your IP, something like ```"192.168.1.4:9300"```
7. Click save and restart Liferay server
8. Loging as an administrator, navigate to Control Panel -> Configuration -> Server Configuration and run reindex.

## Initialize set up after change configurations
1. Stop services with ```docker-compose stop```
2. Run ```docker rm -f `docker ps -qa` ```
3. Run ```docker rmi `docker images | sed -ne '2,$p' -e 's/ */ /g' | awk '{print $1":"$2}'` ```

## Log files
under /es/logs

## How to investigate query of Liferay
Enable slow query log with low threshold would be the easiest way.
1. Navigate to Sense ```http://localhost:5601/app/sense``` e.g.
2. Modify query below appropriately.

```javascript
PUT /[index_name]/_settings
{
    "index.search.slowlog.threshold.query.warn": "0s",
    "index.search.slowlog.threshold.query.info": "0s",
    "index.search.slowlog.threshold.query.debug": "0s",
    "index.search.slowlog.threshold.query.trace": "0s",
    "index.search.slowlog.threshold.fetch.warn": "0s",
    "index.search.slowlog.threshold.fetch.info": "0s",
    "index.search.slowlog.threshold.fetch.debug": "0s",
    "index.search.slowlog.threshold.fetch.trace": "0s",
    "index.indexing.slowlog.threshold.index.warn": "0s",
    "index.indexing.slowlog.threshold.index.info": "0s",
    "index.indexing.slowlog.threshold.index.debug": "0s",
    "index.indexing.slowlog.threshold.index.trace": "0s",
    "index.indexing.slowlog.level": "trace",
    "index.indexing.slowlog.source": "1000"
}
```
3. Search / index and you'll see log files under ./es/logs

## How to access elasticsearch and tools
### Elasticsearch
```http://localhost:9200```

### Sense (Analyzing tool for Elasticsearch)
```http://localhost:5601/app/sense```

### Elastic-HQ
```http://localhost:9200/_plugin/hq```