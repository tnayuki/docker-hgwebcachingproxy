FROM python:2.7-alpine

RUN adduser -h /var/cache/hgwebcachingproxy -D hgwebcachingproxy

RUN apk add --no-cache --virtual .build-deps \
         build-base \
         curl \
    && pip install mercurial gunicorn \
    && curl -o /usr/local/lib/python2.7/site-packages/hgwebcachingproxy.py https://bitbucket.org/Unity-Technologies/hgwebcachingproxy/raw/7ec77742517b4719442916790f605d895ce8de80/hgwebcachingproxy.py \
    && apk del .build-deps

COPY proxy.py /usr/local/lib/python2.7/site-packages/

VOLUME /var/cache/hgwebcachingproxy

COPY gunicorn.conf /
COPY docker-entrypoint.sh /usr/local/bin/

USER hgwebcachingproxy
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 8000
CMD ["gunicorn", "-c", "/gunicorn.conf", "proxy"]
