FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install mercurial gunicorn
ENTRYPOINT ["/usr/bin/gunicorn", "-b0.0.0.0:80", "-t3600", "--access-logfile", "-"]

ADD https://bitbucket.org/Unity-Technologies/hgwebcachingproxy/raw/7ec77742517b4719442916790f605d895ce8de80/hgwebcachingproxy.py /usr/local/lib/python2.7/dist-packages/
COPY proxy.py /usr/local/lib/python2.7/dist-packages/

RUN echo "[extensions]\nlargefiles=" > ~/.hgrc

VOLUME /var/cache/hgwebcachingproxy

EXPOSE 80
CMD ["proxy"]
