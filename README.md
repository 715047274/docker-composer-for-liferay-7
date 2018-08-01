# docker-composer-for-liferay-7

This is for setting up docker-composer to create a env to run Liferay 7.

## Required environment

- Docker 17.06.2-ce >=
- Java8 (Oracle JDK 8 or Open JDK 8)

## How to set up

1.  Clone this repository
2.  Run `reset.sh`
3.  Run `up.sh`
4.  Set the portal to connect on local MySQL instance:
    [database-templates](https://dev.liferay.com/pt/discover/reference/-/knowledge_base/7-0/database-templates)
    `jdbc.default.username=root jdbc.default.driverClassName=com.mysql.jdbc.Driver jdbc.default.password= jdbc.default.url=jdbc:mysql://localhost/lportal?characterEncoding=UTF-8&dontTrackOpenResources=true&holdResultsOpenOverStatementClose=true&useFastDateParsing=false&useUnicode=true`
5.  Set the portal to connect on local Elasticseach instance:
    [configuring-elasticsearch-for-liferay](https://dev.liferay.com/en/discover/deployment/-/knowledge_base/7-0/configuring-elasticsearch-for-liferay-0#configuring-the-adapter-with-an-osgi-config-file).

    ```
    operationMode="REMOTE"
    # If running Elasticsearch from a different computer:
    #transportAddresses="ip.of.elasticsearch.node:9300"
    # Highly recommended for all non-prodcution usage (e.g., practice, tests, diagnostics):
    #logExceptionsOnly="false"
    ```

    You can jump this step and configure the portal on control panel:
    [configuring-the-adapter-in-the-control-panel](https://dev.liferay.com/en/discover/deployment/-/knowledge_base/7-0/configuring-elasticsearch-for-liferay-0#configuring-the-adapter-in-the-control-panel).

6.  _(Additional)_ Enable Felix Gogo Shell telnet connection:
    [liferay-osgi-and-ssh-access](https://community.liferay.com/en/blogs/-/blogs/liferay-osgi-and-ssh-access).

    ```.properties
    module.framework.properties.osgi.console=11311
    ```

7.  _(Additional)_ Disable cache:

    <!-- [liferay-osgi-and-ssh-access](https://community.liferay.com/en/blogs/-/blogs/liferay-osgi-and-ssh-access). -->

    ```.properties
    javascript.log.enabled=false
    javascript.fast.load=false
    theme.css.fast.load=false

    com.liferay.portal.servlet.filters.minifier.MinifierFilter=false
    com.liferay.filters.strip.StripFilter=false

    layout.template.cache.enabled=false

    browser.launcher.url=

    combo.check.timestamp=true

    freemarker.engine.cache.storage=soft:1
    freemarker.engine.modification.check.interval=0

    openoffice.cache.enabled=false

    velocity.engine.resource.manager.cache.enabled=false

    com.liferay.portal.servlet.filters.cache.CacheFilter=false

    com.liferay.portal.servlet.filters.themepreview.ThemePreviewFilter=true
    ```

8.  Start Liferay DXP / 7

## How to access elasticsearch and tools

### Elasticsearch

`http://localhost:9200`

### Kibana (Analyzing tool for Elasticsearch)

`http://localhost:5601`

## How to investigate query of Liferay

Enable slow query log with low threshold would be the easiest way.

1.  Navigate to Sense `http://localhost:5601/app/sense` e.g.
2.  Modify query below appropriately.

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

3.  Search / index and you'll see log files under ./elasticsearch/logs
    you can also change ./elasticsearch/config/elasticsearch.yml for above settings and run `docker-compose up --build`

## Search from query to see how analyzer works.

1.  Navigate to `http://localhost:5601/app/sense` and select server (http://elasticsearch:9200)
2.  Paste query below

```
GET /[index_name]/_analyze
{
  "field": "title_ja_JP",
  "text":  "東京都清掃局"
}
```
