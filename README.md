# Nginx with php5-fpm for OpenShift v3

#### Usage
- Extend the image.
- Create and add needed config. At least nginx default.conf recommended.
- Expose container port 5000.
- Mount volume to /var/www
- If you oveddide Docker entrypoint, add at least following lines:
```bash
#!/bin/bash
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < /workdir/passwd.template > /tmp/passwd
export LD_PRELOAD=libnss_wrapper.so
export NSS_WRAPPER_PASSWD=/tmp/passwd
export NSS_WRAPPER_GROUP=/etc/group

exec "/usr/bin/supervisord"
```
This initializes nss-wrapper to supervisor and other programs that need UID:s work properly.
