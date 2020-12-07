ARG TAG=v1.0
FROM smartcoder/nfpm:${TAG}
ENV NFPM_VERSION=${TAG}

ENTRYPOINT [ "/entrypoint.sh" ]