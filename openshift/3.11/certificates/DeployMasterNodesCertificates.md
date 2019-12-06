# Deploy masters nodes Certificates:

## Edit master-config.yaml with:
```
namedCertificates:
- certFile: /etc/origin/master/named_certificates/proxy.fqdn.cer
  keyfile: /etc/origin/master/named_certificates/proxy.fqdn.key
  names:
  - proxy.fqdn
```

## Run playbook:
```
$ ansible-playbook -i /path/to/inventoryfile playbooks/openshift-master/redeploy-certificates.yml
```

## Run playbook:
```
$ ansible-playbook -i /path/to/inventoryfile playbooks/redeploy-certificates.yml
```
>Note: Check if `named_certificates` folder was upfated with the new certificates.

# Deploy router Certificates:

## Run Playbook:
```
$ ansible-playbook -i /path/to/inventoryfile playbooks/redeploy-certificates.yml
```

# Fix openshift-monitoring:
According to Red Hat Solution `3693251` run the following:

```
$ oc delete secret -n openshift-monitoring alertmanager-main-tls- grafana-tls kube-state-metrics-tls node-exporter-tls prometheus-k8s-tls
$ oc get secret -n openshift-monitoring | grep "\-tls"
$ oc delete pods -n openshift-monitoring --all
```

# Remove certificates from haproxy
## Edit `haproxy.cfg` according to example file below:

```
listen state
    bind :9000
    mode http
    stats enable
    stats uti /

frontend atomic-openshift-api
    bind *:8443
    default_backend atomic-openshift-api
    reqadd X-Forwarded-Proto:\ https
    reqadd X-Forwarded-Port:\ 8443
    rspadd Strict-Transport-Security:\ max-age=15768000
    mode tcp
    option httplog

backend atomic-openshift-api
    bakance source
    mode tcp
    server       master01 ip_address:8443 # ssl verify none
    server       master02 ip_address:8443 # ssl verify none
    server       master03 ip_address:8443 # ssl verify none

frontend atomic-openshift-infra
    bind *:443
    default_backend atomic-openshift-infra
    reqadd X-Forwarded-Proto:\ https
    reqadd X-Forwarded-Port:\ 8443
    rspadd Strict-Transport-Security:\ max-age=15768000
    mode tcp
    option httplog

backend atomic-openshift-infra
    bakance source
    mode tcp
    server       infra01 ip_address:443 # ssl verify none
    server       infra02 ip_address:443 # ssl verify none
    server       infra03 ip_address:443 # ssl verify none
```

## Restart service of haproxy:
```
$ systemctl restart haproxy
```

## See status of haproxy and verify it's up:
```
$ systemctl status haproxy
```
