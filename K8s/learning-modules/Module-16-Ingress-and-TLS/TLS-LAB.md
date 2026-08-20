# TLS Training Lab

Create a temporary self-signed certificate for local learning:

```bash
openssl req -x509 -nodes -days 30 -newkey rsa:2048   -keyout tls.key -out tls.crt   -subj "/CN=student-web.local/O=training"

kubectl create secret tls student-web-tls   --cert=tls.crt --key=tls.key -n student-app
```

Production should normally use managed certificate automation.
