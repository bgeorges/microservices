#Use latest fedora
FROM fedora
#This is the workaround for [Errno -1] repomd.xml does not match metalink for updates
ADD fedora.repo /etc/yum.repos.d/fedora.repo
ADD fedora-updates.repo /etc/yum.repos.d/fedora-updates.repo
# workaround finished
RUN yum -y install httpd mod_cluster
ADD httpd.conf /etc/httpd/conf/httpd.conf
ADD 00-proxy.conf /etc/httpd/conf.modules.d/00-proxy.conf
#
EXPOSE 80
EXPOSE 6666
ENTRYPOINT ["/usr/sbin/httpd", "-D","FOREGROUND"]

