FROM alpine:3.12

ARG KUBE_VERSION="v1.16.10"
ENV AWS_DEFAULT_REGION us-west-1
ENV AWSCLI_VERSION 1.14.50

RUN apk add --no-cache --update bash ca-certificates openssh make gettext \
    python3 py3-pip \
    docker which curl coreutils git && \
    update-ca-certificates && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    pip3 install --upgrade pip && pip install awscli==${AWSCLI_VERSION} --upgrade && \
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
