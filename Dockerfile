FROM python:2.7-alpine

RUN apk add --no-cache --virtual .build-deps \
         build-base \
    && pip install mercurial gunicorn \
    && apk del .build-deps

ADD https://bitbucket.org/Unity-Technologies/hgwebcachingproxy/raw/7ec77742517b4719442916790f605d895ce8de80/hgwebcachingproxy.py /usr/local/lib/python2.7/site-packages/
COPY proxy.py /usr/local/lib/python2.7/site-packages/

RUN echo -e "[extensions]\nlargefiles=" > ~/.hgrc

VOLUME /var/cache/hgwebcachingproxy

COPY gunicorn.conf /
ENTRYPOINT ["/usr/local/bin/gunicorn", "-c", "/gunicorn.conf"]

EXPOSE 8000
CMD ["proxy"]
