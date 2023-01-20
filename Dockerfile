FROM alpine:3.17.1
LABEL maintainer "Lei Zhang <antiagainst@gmail.com>"

WORKDIR /usr/src/app

RUN apk --update add --no-cache --upgrade \
      cppcheck=2.9.1-r0 \
      python3=3.10.9-r1  \
      py3-lxml=4.9.2-r0  && \
    rm -rf /usr/share/ri && \
    adduser -u 9000 -D -s /bin/false app

COPY engine.json /
COPY . ./
RUN chown -R app:app ./

USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/bin/codeclimate-cppcheck"]
