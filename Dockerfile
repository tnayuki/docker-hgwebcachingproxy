FROM python:2.7-alpine

RUN apk add --no-cache --virtual .build-deps \
         build-base \
    && pip install mercurial gunicorn \
    && apk del .build-deps
ENTRYPOINT ["/usr/local/bin/gunicorn", "-b0.0.0.0:80", "-t3600", "--access-logfile", "-"]

ADD https://bitbucket.org/Unity-Technologies/hgwebcachingproxy/raw/7ec77742517b4719442916790f605d895ce8de80/hgwebcachingproxy.py /usr/local/lib/python2.7/site-packages/
COPY proxy.py /usr/local/lib/python2.7/site-packages/

RUN echo -e "[extensions]\nlargefiles=" > ~/.hgrc

VOLUME /var/cache/hgwebcachingproxy

EXPOSE 80
CMD ["proxy"]
