#!/bin/sh

chown hgwebcachingproxy:hgwebcachingproxy /var/cache/hgwebcachingproxy

echo -e "[extensions]\nlargefiles=" > ~/.hgrc

exec $@
