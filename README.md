### Airkorea gRPC server 
  
```shell
$ docker build -t airkorea/server
$ echo "key value" > key.conf
$ docker run --rm -d -p 9090:9090 --env PORT=9090 --env KEY=`cat key.conf` --name airkorea airkorea/server
```
