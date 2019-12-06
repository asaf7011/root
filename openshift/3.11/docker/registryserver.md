## Create a httpasswd file with the user for authentication:
`
htpasswd -cB /etc/docker-distribution/registry_passwd <registry_username>
`
```
 htpasswd -cB /etc/docker-distribution/registry_passwd test
 ```
 ## Edit the following file:
 ` /etc/docker-distribution/registry/config.yml `
 ```
 version: 0.1
 log:
   fileds:
      service: registry
 storage:
     cache:
         layerinfo: inmemory
     filesytem:
          rootdirectory: /var/lib/registry
 http:
     addr: :5000
     tls:
        certificate: /etc/docker-distribution/certs/registry.crt
        key: /etc/docker-distribution/certs/registry.key
     host: https://FQDN:5000
     secret: randomvalue
     relativeurls: false
 auth:
     htpasswd:
       realm: basic-realm
       path: /etc/docker-distribution/registry_passwd
```
`systemctl restart docker-distribution.service`

### to verify all is well, run the command:
`curl -u <registry_username>:<password> -k https://FQDN:5000/v2/_catalog`


`The result should return:`
```
{repoitories":[]}
```
