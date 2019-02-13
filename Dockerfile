FROM scratch
ARG BIN_PATH=release/coredns-linux-amd64
COPY ${BIN_PATH} /bin/coredns

ENV PATH=/bin
ENV TMPDIR=/
ENTRYPOINT ["/bin/coredns"]
