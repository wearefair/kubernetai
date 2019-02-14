FROM scratch
ARG BIN_PATH=release/coredns-linux-amd64
COPY ${BIN_PATH} /bin/coredns
ADD https://curl.haxx.se/ca/cacert.pem /etc/ssl/ca-bundle.pem

ENV PATH=/bin
ENV TMPDIR=/
ENTRYPOINT ["/bin/coredns"]
