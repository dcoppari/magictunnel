#!/bin/sh

if [ ! -z "$SSH_PRV_KEY" ]; then

    # Install certificate
    echo "$SSH_PRV_KEY" > /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa

    # Make connection to the remote server
    echo "Trying to forward port $REMOTE_PORT on $SSH_USER@$SSH_HOST:$SSH_PORT"
    nohup ssh -nNT -o StrictHostKeyChecking=no -p $SSH_PORT $SSH_USER@$SSH_HOST -L 3000:127.0.0.1:$REMOTE_PORT &

fi;

cd /
exec "$@"
