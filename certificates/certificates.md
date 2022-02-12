# Generate root-ca certificate
- Generate key: openssl genrsa -aes256 -out ca/key.pem 4096
- Generate cert: openssl req -x509 -new -nodes -extensions v3_ca -key ca/key.pem -days 3650 -out ca/certificate.pem -sha512 -config config/openssl_ca.cnf
- Convert cert: openssl x509 -outform der -in ca/certificate.pem -out ca/certificate.crt

# intermediate
- Generate key:     openssl genrsa -aes256 -out ica/key.pem 4096
- Generate request: openssl req -new -nodes -key ica/key.pem -out ica/request.csr -days 3650 -config config/openssl_ica.cnf
- Generate cert:    openssl ca -extensions v3_ca -notext -in ica/request.csr -out ica/certificate.pem -config config/openssl_ica.cnf -cert ca/certificate.pem -keyfile ca/key.pem -create_serial
- Convert cert:     openssl x509 -outform der -in ica/certificate.pem -out ica/certificate.crt

# Generate certificate
- Generate key:     openssl genrsa -aes256 -out web/key.pem 4096
- Generate request: openssl req -new -nodes -key web/key.pem -out web/request.csr -config config/openssl_web.cnf
- Generate cert:    openssl x509 -req -days 730 -in web/request.csr -CA ica/certificate.pem -CAkey ica/key.pem -CAcreateserial -out web/certificate.pem -extfile config/openssl_web.cnf -extensions v3
- Convert cert:     openssl x509 -outform der -in web/certificate.pem -out web/certificate.crt

# Generate certificate chain (bei nginx nicht nötig)
https://medium.com/@hasnat.saeed/setup-ssl-https-on-jboss-wildfly-application-server-fde6288a0f40

openssl pkcs12 -export -out nginx.pfx -in web/certificate.pem -inkey web/key.pem -certfile ica/certificate.pem
