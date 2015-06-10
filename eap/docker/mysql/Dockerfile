#Use latest fedora
FROM fedora
#This is the workaround for [Errno -1] repomd.xml does not match metalink for updates
ADD fedora.repo /etc/yum.repos.d/fedora.repo
ADD fedora-updates.repo /etc/yum.repos.d/fedora-updates.repo
# workaround finished
#RUN yum update
#RUN yum -y install openssl-libs-1.0.1e-30.fc20.x86_64
RUN yum -y install community-mysql-server community-mysql
RUN mysql_install_db
RUN chown -R mysql:mysql /var/lib/mysql 
ADD setup.sql /setup.sql
ADD run.sh /run.sh
RUN chmod 755 /*.sh /*.sql
#
EXPOSE 3306
ENTRYPOINT ["/run.sh"]

