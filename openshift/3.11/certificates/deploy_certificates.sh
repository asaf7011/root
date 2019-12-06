#!/bin/bash
certutil -d sql:$HOME/.pki/nssdb -A -t "C,," -n navy -i /usr/local/share/ca-certificates/certname.fqdn.crt