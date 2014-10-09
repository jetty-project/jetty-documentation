
s/jetty-distribution-[7-9].[0-3].[0-9]*.[v0-9RCM]*/jetty-distribution-@project.version@/g
s/jetty-\([a-z-]*\)-[7-9]\.[0-3]\.[0-9]*\.[v0-9RCM]*\.jar/jetty-\1-@project.version@.jar/g
s/@project.version@DEMO/@project.version@/g
s/9\.1\.0\.RC0/@project.version@/g
s/9\.1\.0\.RC1/@project.version@/g
s/9\.1\.0-DEMO/@project.version@/g
s/Server:.*jetty-${project.version}/Server:main: jetty-@project.version@/g
s@/Users/jesse/Desktop/jetty-dist@/home/user/jetty-dist/@g
s@/home/joakim/java/@/usr/lib/jvm/@g
s@/home/user/java/@/usr/lib/jvm/@g
s@/home/joakim/code/intalio/distros/@/home/user/@g

