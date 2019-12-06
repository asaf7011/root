# Openshift Certificates Proccess

## Inroduction
Openshift enviroment arrive with selg-signed certificates (openshift-signer) As part of security response we asked for deploying FQDN Certificates:

for wildcard certificates: `*.subdomain.fqdn.key`

for proxy certificates: `dnsrequrd.fqdn`

## Create request file for proxy & wildcard and send them for sign in CA Server:
```
$ openssl req -nodes -newkey rsa:4096 -keyout dnsrequrd.fqdn.key -out dnsrequrd.fqdn.csr -sha256
```
1. press 2 times `Enter`
1. In `Common name` insert the wildcard\proxy name and keep pressing `Enter` until the end of the wizard.
1. Send the files for signe in CA Server.
1. Ca Server team will provide a `.crt` file wich you need to convert to `.cer`. You can do this on a Windows worksatation like so:
    1. Double click on the `.crt`
    1. `Details`->`Copy to File`->`Next`->`Base-64 encoded x.509 (.CER)`->`Next`->`insert file name`->`Next`->`Finish`
1. Transfer the `.cer` file back to the Server.

## Deploy Certs

1. Convert `.der` file to `.pem`
> Note If you do not have rootCA `.pem` files, you can copy those files from another DEV env>

```
$ openssl x509 -inform der -in rootCA.cer -out rootCA.pem
```

```
$ openssl x509 -inform der -in anotherootCA.cer -out anotherrootCA.pem
```

2. Check the Signed certificates from CAServer team (based on the .cer file above):
```
$ openssl rsa -modulus -noout -in proxy.fqdn.key | openssl md5
```

```
openssl x509 -noout -modulus -in proxy.fqdn.cer | openssl md5
```
>__Note: Should produce the same result md5 hash__
3. Attach all relevant files to `.pem`
>  Note: do this one to PROXY certificate and once for WILDCARD
``` 
$ cat proxy.fqdn.key proxy.fqdn.cer rootCA.pem anotherrootCA.pem > proxy.fqdn.pem
```
4. Update the inventory file before deploying, and follow the next DeployMasterNodesCertificates.md file.