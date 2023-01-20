FROM alpine:3.17.1
LABEL maintainer "Lei Zhang <antiagainst@gmail.com>"

WORKDIR /usr/src/app

RUN apk --update add --no-cache --upgrade \
      cppcheck=2.9.1-r0 \
      python3=3.10.9-r1 \
      py3-lxml=4.9.2-r0 \
      sudo \
      bash=5.2.15-r0 && \
    rm -rf /usr/share/ri

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY engine.json /
COPY . ./

USER root

VOLUME /code
WORKDIR /code

#CMD ["/usr/src/app/bin/codeclimate-cppcheck"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
