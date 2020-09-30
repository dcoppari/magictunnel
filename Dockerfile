FROM nginx:alpine

ARG SSH_PRV_KEY
ARG SSH_PUB_KEY

ENV SSH_HOST ""
ENV SSH_PORT "22"
ENV SSH_USER "automata"
ENV REMOTE_PORT "80"

RUN apk update && apk add openssh curl

# Create SSH config and add keys
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    echo "$SSH_PRV_KEY" > /root/.ssh/id_rsa && \
    echo "$SSH_PUB_KEY" > /root/.ssh/id_rsa.pub && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub

# Copy NGINX proxy configuration
COPY default.conf /etc/nginx/conf.d/
#COPY index.html /usr/share/nginx/html/

# Entrypoint
COPY ./entrypoint.sh /

RUN chmod +x /entrypoint.sh

# Monitoring SSH connection
HEALTHCHECK CMD curl --fail http://localhost:8080/ || exit 1

WORKDIR /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
