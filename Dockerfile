FROM alpine:3.7

RUN apk add --no-cache --update bash && \
    apk add make && \
    apk add git

WORKDIR /gladly/build-harness

COPY . .

ENTRYPOINT ["/bin/bash"]