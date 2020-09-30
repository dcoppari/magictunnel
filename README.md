# Use NGINX PROXY to access a remote ssh port forwarded service

## Build Image

You need to pass the certificates that container will use to connect the remote server:

```bash
docker build -t dcoppari/magictunnel .
```

## Run Image

In order to run image you must set the environment variables where the image will connect to forward the port

```bash
docker run --rm -d -p "80:80" \
     --env SSH_PRV_KEY="$(cat ~/.ssh/id_rsa)" \
     --env SSH_USER="root" \
     --env SSH_HOST="some.remote-server.com" \
     --env SSH_PORT="22" \
     --env REMOTE_PORT="80"
```

### Test

You now can make a curl request to test if the service is working as spected

```back
curl http://localhot:80
```
