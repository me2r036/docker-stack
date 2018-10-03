## Docker developer stack

### What's Docker

Docker is a contaner tech stack.

## Basic concepts

### Resources In Container
1. CPU/Mem
    Share from Host

2. OS 
    Any Unix/Linux OS release version is avialable, and can be visualized.
    It's totally seperate from Host OS
3. Network
    It will create a sub private network group.
    And the network group can defined/customized

4. Storage
    It's posible to use it's own file system in container(That means it will be seperated from host)
    Or you can mount host's folder to share data between Host and container

5. Service
    Container need to run a service to let contain keep live.

### Host and Container
```shell
__________________________________________________________________HOST___________________________________________________________________
|                                                                  
|     ------------------Container Group-------                                                       -----More Container Group...-----
|     |                                       |                                                      |                                |
|     |     -------Container 1------          |                          ____________                |                                |
|     |     |                      |          |                          |          |                |                                |
|     |     |      nginx service   |<----------log folder mount--------->|          |<-folder mount->|                                |
|     |     |        (Webproxy)    |          |                          |          |                |                                |
|     |     |        http:80       |          |        ____________      |          |                |                                |
|     |     |        https:44s     |<--TCP Port map--->|          |      |          |                |________________________________|
|     |     |----------------------|          |        |   Host   |      |          |
|     |                                       |        | Network  |      |     H    |
|     |     -------Container 2------          |        |          |      |     O    |
|     |     |                      |          |        |----------|      |     S    |
|     |     |    varnish service   |          |                          |     T    |
|     |     |        http:80       |<----------log folder mount--------->|          |
|     |     |----------------------|          |                          |     F    |
|     |                                       |                          |     I    |
|     |     -------Container 3------          |                          |     L    |
|     |     |                      |<----------log folder mount--------->|     E    |
|     |     |    magento webtier   |          |                          |          |
|     |     |        http:80       |<---  Magento project folder   ----->|     S    |
|     |     |----------------------|          |                          |     Y    |
|     |                                       |                          |     S    |
|     |     -------Container 4------          |                          |     T    |
|     |     |                      |<----------log folder mount--------->|     E    |
|     |     |     mysql service    |          |                          |     M    |
|     |     |     mysql:3306       |<-------share data folder mount----->|          |
|     |     |----------------------|          |                          |          |
|     |                                       |                          |          |
|     |     -------Container 5------          |                          |          |
|     |     |                      |          |                          |          |
|     |     |      redis service   |<----------log folder mount--------->|          |
|     |     |        redis:6379    |          |                          |          |
|     |     |----------------------|          |                          |          |
|     |                                       |                          |          |
|     |     -------Container 6------          |                          |          |
|     |     |                      |          |                          |          |
|     |     |   rabbitmq service   |<----------log folder mount--------->|          |
|     |     |        http:80       |          |                          |          |
|     |     |----------------------|          |                          |          |
|     |                                       |                          |          |
|     |     -------Container 7------          |                          |          |
|     |     |                      |          |                          |          |
|     |     |elastic search service|<------index data folder mount-----> |          |
|     |     |       http:9200      |          |                          |          |
|     |     |----------------------|          |                          |          |
|     |                                       |                          |          |
|     |     -------Container 8------          |                          |          |
|     |     |                      |          |                          |          |
|     |     |     kibana service   |          |                          |          |
|     |     |       http:5601      |          |                          |          |
|     |     |----------------------|          |                          |          |
|     |                                       |                          |          |
|     |     -------Container 9------          |                          |          |
|     |     |                      |          |                          |          |
|     |     |   logstash service   |          |                          |          |
|     |     |                      |          |                          |          |
|     |     |----------------------|          |                          |          |
|     |                                       |                          |          |
|     |     -------Container 10-----          |                          |          |
|     |     |                      |          |                          |          |
|     |     |    filebeat service  |<-Other container log folders mount<-|          |
|     |     |                      |          |                          |          |
|     |     |----------------------|          |                          |__________|
|     |______________________________________ |
|     
|_______________________________________________________________________________________________________________________________________
```


### Docker image
Just like VM image, but it's much lighter and it can be released just by Dockerfile, or it can be released as an image.

### Dockerfile
Dockerfile is a configuration script which you can build your base docker image to run.

And for a given Dockerfile we can using command line to build docker image:
```shell
sudo docker build -t 'docker-image-version' Dockerfile
```

### Docker-compose
### Container and service

### Environment variables

## Services

### Webproxy

Webproxy is main entry point for http request.

It's main features include:
1. Dispatch request to Varnish pool or magento2 servers pool
2. Convert https request to http since Varnish doesn't support https.

**Defined variables:**
Webproxy service has defined these variables:
1. USING_VARNISH
   options:  'yes', 'no'
2. VARNISH_NODE0
    Any Varnish service defined in your docker-compose.yml is acceptable

3. VARNISH_NODE1
    Any Varnish service defined in your docker-compose.yml is acceptable

4. MAGE_NODE0
    Any magento2 service defined in your docker-compose.yml is acceptable

5. MAGE_NODE1
    Any magento2 service defined in your docker-compose.yml is acceptable

6. MAGE_NODE2
    Any magento2 service defined in your docker-compose.yml is acceptable

7. MAGE_NODE3
    Any magento2 service defined in your docker-compose.yml is acceptable

### Varnish

Varnish tier will accept request from Webproxy, and base on it's configuration, try to cache by rule we defined, and deliver hit cache resource, or pass miss cache resource to it's backend. And it's next tier should be magento2 tier.

**Defined variables:**
Webproxy service has defined these variables:
1. MAGE_NODE0
    Any magento2 service defined in your docker-compose.yml is acceptable

2. MAGE_NODE1
    Any magento2 service defined in your docker-compose.yml is acceptable

3. MAGE_NODE2
    Any magento2 service defined in your docker-compose.yml is acceptable

4. MAGE_NODE3
    Any magento2 service defined in your docker-compose.yml is acceptable

### Service list
#### redis
#### rabbitmq
#### db
mysql5.7
#### magento2
#### ELK stack
##### elasticsearch
##### kibana
##### logstash
##### filebeat

## Useful command lines
```shell
# list docker container
docker ps

# list docker images
docker images

# build docker image
docker build

# stop a contianer
docker stop

# start a container
docker start

# run a command line in docker
docker exec
```
### run command line from host
We can run container's command line from host directly and get output from console

```shell
sudo docker-compose exec magento2 php /var/www/html/bin/magento
```

## How to use

#### Install docker to your host
https://docs.docker.com/install/

#### Checkout Docker stack repo
```shell
git clone ssh://git@10.150.20.213:7999/ecmag/docker.git docker-stack
```

#### Config .env
```shell
cd docker-stack
vim .env
```
And here's an example .env file
```shell
MYSQL_ROOT_PASSWORD=password123!
USING_VARNISH=yes
VARNISH_NODE0=varnish
VARNISH_NODE1=''
MAGE_NODE0=magento2
MAGE_NODE1=''
MAGE_NODE2=''
MAGE_NODE3=''
MAGE_PROJECT_FOLDER=/var/www/codebase/magento2/current
ELK_VER_TAG=6.0.1
ELASTIC_VERSION=6.0.1
ELASTIC_PASSWORD=Elk@p@ssw0rd
ELASTIC_SEARCH_INDEX_DATA=./elasticstack/data/20180323
MAGE_NGX_CONST=./configs/magento2/nginx/const
MAGE_NGX_RULES=./configs/magento2/nginx/rules
```

#### Start docker stack
```shell
sudo docker-compose up -d

#run this command line to check
sudo docker ps --format "table {{.ID}}\t{{.Names}}"
```

#### Import DB data for Magento2
  Init sql text file share/CMInit.sql

```shell
 sudo docker-compose exec db /usr/bin/mysql -uroot -ppassword123! magento_sales < ./share/CMInit.sql
```

#### Split Magento database
```shell
sudo docker-compose exec db /usr/bin/mysql -uroot -ppassword123! -Bse 'create database magento_quote;'
sudo docker-compose exec db /usr/bin/mysql -uroot -ppassword123! -Bse 'create database magento_sales;'

sudo docker-compose exec magento2 php  /var/www/html/bin/magento setup:db-schema:split-quote --host="db" --dbname="magento_quote" --username="root" --password="password123!"
sudo docker-compose exec magento2 php  /var/www/html/bin/magento setup:db-schema:split-sales --host="db" --dbname="magento_sales" --username="root" --password="password123!"
```
