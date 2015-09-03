FROM centos:centos6
RUN sed -i 's/mirrorlist=http/#mirrorlist=http/g'                                    /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i 's!#baseurl=http://mirror.centos.org!baseurl=http://ftp.riken.jp/Linux!g' /etc/yum.repos.d/CentOS-Base.repo
RUN yum -y install which
RUN yum -y install perl
RUN yum -y install tar
RUN yum -y install gcc-c++
RUN yum -y install libicu-devel.x86_64
RUN yum -y install sudo

RUN useradd hubot
RUN usermod -G wheel hubot
RUN sed -i 's/# %wheel/%wheel/g' /etc/sudoers
RUN sed -i "s/Defaults    requiretty/#Defaults    requiretty/g" /etc/sudoers
RUN echo "root:root" | chpasswd

# supervisord
RUN curl -k -L http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm > epel-release-6-8.noarch.rpm
RUN rpm -ivh epel-release-6-8.noarch.rpm
RUN rm -f epel-release-6-8.noarch.rpm
RUN yum -y install supervisor --enablerepo=epel
RUN chkconfig supervisord on
RUN mkdir /var/log/supervisor/hubot-slack
ADD ./src/supervisord.conf /etc/

USER hubot
RUN mkdir /home/hubot/myslackbot
WORKDIR /home/hubot/myslackbot

RUN curl -k -L git.io/nodebrew | perl - setup
ENV PATH /home/hubot/.nodebrew/current/bin:$PATH
RUN nodebrew install v0.10.35
RUN nodebrew use 0.10.35
ENV PATH /home/hubot/myslackbot/node_modules/.bin:$PATH

RUN npm install  generator-hubot
RUN npm install  yo
RUN npm install  coffee-script
RUN npm install  hubot
RUN npm install  hubot-slack

RUN yes | yo hubot --defaults

ADD ./src/run_hubot.sh ./bin/
RUN sudo chmod +x ./bin/run_hubot.sh

RUN sed -i "s/npm install/#npm install/g" ./bin/hubot
