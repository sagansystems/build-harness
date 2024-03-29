FROM alpine:3.19

ARG KUBE_VERSION="v1.27.11"
ENV AWS_DEFAULT_REGION us-west-2
ENV AWSCLI_VERSION 1.29.50

RUN apk add --no-cache --update aws-cli bash ca-certificates jq openssh make gettext \
    docker which curl coreutils git && \
    update-ca-certificates && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    apk upgrade --no-cache && \
    # Cleanup uncessary files
    rm -rf /tmp/*


# Avoid unknown host for github
RUN mkdir -p ~/.ssh/ && echo -e "Host github.com\n\tStrictHostKeyChecking no\n" > ~/.ssh/config

ENV BUILD_HARNESS_PATH /gladly/build-harness
ENV KUBECTL_CMD /usr/local/bin/kubectl
ENV KUBECTL /usr/local/bin/kubectl
ENV KUBEUTIL $BUILD_HARNESS_PATH/kube-util
WORKDIR $BUILD_HARNESS_PATH

COPY . .

ENTRYPOINT ["/bin/bash"]
