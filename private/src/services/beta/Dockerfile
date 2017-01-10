FROM alpine:3.4

RUN  apk add --update ca-certificates && \
     rm -rf /var/cache/apk/*

EXPOSE 80

COPY /beta /beta

CMD ["/beta"]
