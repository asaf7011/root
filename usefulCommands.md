## Find command examples:
```
find . -type | grep F | wc -l 
```
``` 
ssh-keygen -R hostname
```
---------------------
## Used Command:
```
namp -Pn (ip)
```
```
lsblk
```
```
lsb_release -a
```
```
nmcli dev show | grep DNS
```
```
ip route | grep default (show default getway)
```
```
gdm3 - GNOME Display Manager
```
```
sudo shiw apt-cache show (git) {shiw depends of deb}
```
```
du -csh ./* | grep M/G/K
```
```
df -h
```
```
df -t
```
```
findmnt
```
```
sudo lshw -C disk
```
```
getnet passwd | grep -i (username) {check user display in ad}
```
```
vim-> colorscheme (tab)
```
```
ps -ef | grep (java) {some service name}
```
```
dig -x (ip addres)
```
```
cat /etc/ansible/hosts | xargs -i ssh-copy-id {}
```
```
ss -tulnp | grep tcp
```

---
## Upgrade rhel os version:
```
change the relevente file on /etc/yum.repos.d/
```
```
yum chec-update
```
```
yum update
```
```
yum update --disableexcudes=all -y
```
```
package-cleanup --dupes
```
```
package-cleanup --cleandupes
```
```
package-cleanup --cleandupes --removenewestdupes 
```
```
cat /etc/redhat-release or hostnamectl
```
---
## Sort+Diff:
```
sort (filename) > (filename).sorted
```
```
vimdiff (filename) (filename).sorted
```
---
## Openssl create key & csr files:
` openssl req -nodes -newkey rsa:4096 -keyout wildcard.fqdn.key -out wildcard.fqdn.csr -sha256 `


---
## More 'for' command:
```
for host in "hostname" "hostname2" ; do scp /path/to/file $host:/path/to/dest ; done
```
```
for host in "hostname" "hostname2" ; do ssh $host "update-ca-trust extract"(or else command that need); done
```
```
for host in "hostname" "hostname2" ; do docekr login https://url.fqdn:5000v--username="username" --password="password"; done
```
## Docker file conf:
```
ADD_REGISTRY='--add-registry hostname.fqdn:5000 -add-registry registry.redhat.io
```
```
INSECURE_REGISTRY='--insecure-registry docker.artifactory'
```
---
## Nsupdate:
` nsupdate > ` 
```
update add hostname.fqdn 86400 A ipaddress
```
---
## ssh problem:
```
ssh-keygen -R hostname
```
---
## Show rpm in rhel: 
```
rpm -qa | grep (packagename)
```
## Search rpm dependencies:
```
rpm -qpR (craterepo.noarch)
```
or
```
yum install (packagename)
```
```
yum list installed | grep (packagename)
```
---
## Docker storage:

` 1. Edit the file on: /etc/sysconfig/docker-storage-setup `

` 2. systemctl stop docker `

` 3. docker-storage-setup `

` 4. lvextend /dev/docker-vg/docker-pool -l +100%FREE `

` 5. systemctl start docker `

` 6. systemctl enable docker `

` **before all make sure systemctl stop docker && status docker** `

---
## Pvcreate:
` pvcreate /dev/sdb1 `

` vgcreae export /dev/sdb1 `

` lvcreate export --name kafka-data -L +70G `

` mkfs.xfs /dev/mapper/export-kafka--data `

## Disk check:
` dstat -cd --disk-util --disk-tps `

` iostat -y 5 /dev/sda `
```
write test: sync;dd if=/dev/zero of=tempfile bs=1M count=1024;
```
```
read test: dd if=tempfile of=/dev/null bs=1M count=1024
```
```
clear cach: /sbin/sysctl -w vm.drop_caches=3 vm.drop_caches=3
```

## Tmux:

` ctrl+b+%  (split) `

` ctrl+b+[ (q-to quit) `

## Jfrog cli:
` for artifactory search run command: `
```
jfrog rt search docker/*/manifest/*
```
` for delete `
```
jfrog rt delete docker/aoutotesting7.0/0.0/*
```


## Ansible remote host ping:
```
ansible all -i /path/to/inventoryfile -m ping --ask-pass --ask-sudo-pass
```

## Show all pack that install:
```
dpkg -l | grep (package_name)

apt list --installed | less
```

## Show remote server uptime:
```
ansible (webservers/group name in hosts file) -a "uptime"
```
```
ansible -i /path/to/inventoryfile -m shell -a "reboot"
```
```
ansible -i /path/to/inventoryfile -m ping
```
```
ansible -i /path/to/inventoryfile -m copy "src=/path/to/file dest=/path/to/file"
```


---------------------

## Restart dns service on local host:

` sudo /etc/init.d./dnsmasq restart `

` sudo /etc/init.d./nscd restart `

## Extend lv:
```
lvextend -l 100%FREE /dev/rhel/root
Then --> 
xfs_growfs /dev/mapper/rhel-root 
 ```
` lvdisplay `
```
lvcreate -n var -L 220G rhel
mkfs.xfs /dev/rhel/var
```

## Git Command:
` commit `

` branch `

` checkput `

` cherry-pick `

` reset `

`rebase `

` merge `

` build level `

` show commands `

` git merge `

` help level `

` git rebase `

` git reset `

` git revert `

` git cherry-pick `

` rebase -i ` {reorder the commits}

` git describe `

` git checkput master^ `

---
## Permit root login for ssh remote login:
1. vi to /etc/ssh/sshd-config

2. Edit the line:
```
PermitRootLogin without-password -> PermitRootLogin yes
```
---
## Docker Commands:
` **sudo before all command** `
```
docker ps -a (shows all container)

witout -a (show all running at all)
```
```
docker rmi (remove docker images via imageID)
```
```
docker build -</path/to/dockerfile
```
```
docker build -f /path/to/dockerfile .
```
```
docker inspect (container id)
```
```
docker login (docker.artifactory)
```
```
docker pull docker.artifactory/gradle:jdk8-alpine
```
```
docker run -d --name test5 -it docker.artifactory/debian:latest bash (run simple container from image) {docker.artifactory/debian:latest}
```
```
docker exec -it my_web1.0 bash (only if specipic container is started)
```
```
docker images | grep dcoker.artifactory/gradle* | awk {print $1 ":" $2 ":" $7 $8}' | xargs sudo docker rmi -f
```
```
docker images | grep 3.11.88 | awk '{print $1 ":" $2 ":" $7 $8}' |wc -l
```
```
docker images | awk '{print $1 ":" $2}' | grep hostname.fqdn | xargs -L1 docker push
```
## Docker tag & push:
```
for image in $(ls -1 /dockeroutput | tr '\n' ' '); do echo ---- $iamge ---- ; docker load -i $image ; done
```
```
for image in $(docker images | grep 117 | awk '{print $1 ":" $2}') ; do echo --- $image --- ; docker tag $image $(echo $image | sed 's/hostname.fqdn/newhostname.fqdn:500/g') ; done
```
` For taging spacific image do the next phase: `
```
docker tag hostname.fqdn/rhel/etcd:3.2.22 newhostname.fqdn:5000/rhel/etcd:3.2.22
```
```
for image in $(docker images | grep hostname.fqdn | grep v3.11.117-2 | awk '{print $2 ":" $2}') ; do docker push $image ; done
```


## Jenkinsfile:
```
bs -j 40 --with-distcc -p
```
## More oc command:
```
oc get ns -ojson validate
```
```
oc patch -h 
```
---
## Openshift health check:
```
etcdctl --cert-file=$ETCD_PEER_CERT_FILE --key-file=$ETCD_PEER_KEY_FILE --ca-file=/etc/etcd/ca.crt --endpoints=$ETCD_LISTEN_CLIENT_URLS cluster-health
```
---
## Deploy custom ca on lnx station:
1. install libnss3-tools

2. copy certfile.crt to /usr/local/share/ca-certificates

3. sudo certutil -d sql:$HOME/.pki/nssdb -A -t "C,," -certname -i /usr/local/share/ca-certificates/certname.crt /usr/local/share/ca-certificates/certname.fqdn.crt

4. sudo update-ca-certifictes

5. exit & reopen chrome

` certutil -d sql:$HOME/.pki/nssdb -N `


----
## Check if vMWare tools installed: 
```
vmware-toolbox-cmd -version
```

