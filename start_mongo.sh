
docker run -v /tmp/:/config/ -d -h mongo-1  --name=mongo-1  mongo:latest /usr/bin/mongod -f  /config/mongod.conf
docker run -v /tmp/:/config/ -d -h mongo-2 --name=mongo-2  mongo:latest /usr/bin/mongod -f  /config/mongod.conf
docker run -v /tmp/:/config/ -d -h mongo-3 --name=mongo-3  mongo:latest /usr/bin/mongod -f  /config/mongod.conf
sleep 3
docker exec -it mongo-1 /usr/bin/mongo --eval "rs.initiate()"
docker exec -it mongo-2 "echo 172.17.0.2 mongo-1 >> /etc/hosts"
docker exec -it mongo-2 /usr/bin/mongo --eval "rs.add('172.17.0.3')" --host "172.17.0.2"
docker exec -it mongo-3 "echo 172.17.0.2 mongo-1 >> /etc/hosts"
docker exec -it mongo-3 /usr/bin/mongo --eval "rs.add('172.17.0.4')" --host "172.17.0.2"
