FROM alpine
MAINTAINER technik@myfoodmap.de

RUN apk add --update \
    py-pip \
    gpgme \
    xz \
    && rm -rf /var/cache/apk/*

RUN pip install awscli
RUN pip install b2

ADD backup.sh /backup.sh
ADD restore.sh /restore.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

CMD ["/run.sh"]
