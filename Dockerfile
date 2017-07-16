FROM node:8.1

RUN mkdir /opt/hubot
WORKDIR /opt/hubot

RUN npm install -g hubot coffee-script yo generator-hubot

RUN chown -R node /opt/hubot
USER node

RUN yo hubot --owner="nemupm" --name="Hubot" --description="bot" --adapter=slack --defaults --allow-root

RUN npm install hubot-slack
RUN npm install hubot-youtube
RUN npm install nemupm/hubot-docomo-dialog.git#master

ADD external-scripts.json /opt/hubot/external-scripts.json

ENV HUBOT_SLACK_TOKEN=xxxxxxxxxxxxxxxxxxxx
ENV DOCOMO_API_KEY=xxxxxxxxxxxxxxxxxxxx

CMD ["./bin/hubot", "--adapter", "slack"]
