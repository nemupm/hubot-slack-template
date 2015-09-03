# 1. exec 'docker build -t image_name ./' to make docker image
# 2. exec 'docker run --name container_name -i -t -d image_name'
# 3. exec 'docker exec -it container_name bash' to enter the container
# 4. edit /home/hubot/myslackbot/bin/run_hubot.sh to set environment variables(eg: TOKEN)
# 5. exec 'service supervisord on'
# (6. if you wanna add other hubot scripts, 'npm install <scripts> --save' and edit external-scripts.json)

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
RUN mkdir /var/log/supervisord/hubot-slack
ADD src/supervisord.conf /etc

USER hubot
RUN mkdir /home/hubot/myslackbot
WORKDIR /home/hubot/myslackbot

RUN curl -k -L git.io/nodebrew | perl - setup
RUN nodebrew install v0.10.35
RUN nodebrew use 0.10.35

RUN npm install  generator-hubot
RUN npm install  yo
RUN npm install  coffee-script
RUN npm install  hubot
RUN npm install  hubot-slack

RUN yes | yo hubot --defaults

ADD src/run_hubot.sh ./bin
RUN chmod +x ./bin/run_hubot.sh

RUN sed -i "s/npm install/#npm install/g" ./bin/hubot
RUN mkdir log

#ENV HUBOT_SLACK_TOKEN 12345
#RUN hubot -a slack