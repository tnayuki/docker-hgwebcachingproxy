import hgwebcachingproxy
import os

application = hgwebcachingproxy.proxyserver(serverurl=os.environ['HGWEBCACHINGPROXY_SERVER_URL'], cachepath='/var/cache/hgwebcachingproxy/')
