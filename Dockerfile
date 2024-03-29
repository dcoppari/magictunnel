FROM nginx:alpine

ENV SSH_PRV_KEY ""
ENV SSH_HOST ""
ENV SSH_PORT "22"
ENV SSH_USER "root"
ENV REMOTE_PORT "80"

RUN apk update && apk add openssh curl

# Create SSH config dir
RUN mkdir -p /root/.ssh

# Copy NGINX proxy configuration
COPY default.conf /etc/nginx/conf.d/

# Entrypoint
COPY ./entrypoint.sh /

RUN chmod +x /entrypoint.sh

# Monitoring SSH tunnel
HEALTHCHECK CMD curl --fail http://127.0.0.1:3000/ || exit 1

WORKDIR /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
