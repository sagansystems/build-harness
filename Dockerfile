FROM alpine:3.7

ARG KUBE_VERSION="v1.8.7"

RUN apk add --no-cache --update bash && \
    apk add ca-certificates && update-ca-certificates && \
    apk add openssh && \
    apk add make && \
    apk add docker && \
    apk add curl && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    apk add git && \
    # Cleanup uncessary files
    rm /var/cache/apk/* && \
    rm -rf /tmp/*


# Avoid unknown host for github
RUN mkdir -p ~/.ssh/ && echo -e "Host github.com\n\tStrictHostKeyChecking no\n" > ~/.ssh/config

ENV BUILD_HARNESS_PATH /gladly/build-harness

WORKDIR /gladly/build-harness

COPY . .

ENTRYPOINT ["/bin/bash"]