#!/bin/sh

# Make connection to the server
echo "Trying to forward port $REMOTE_PORT on $SSH_USER@$SSH_HOST:$SSH_PORT"

cd /

nohup ssh -nNT -o StrictHostKeyChecking=no -p $SSH_PORT $SSH_USER@$SSH_HOST -L 3000:127.0.0.1:$REMOTE_PORT &

exec "$@"
