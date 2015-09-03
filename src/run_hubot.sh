#!/bin/sh

cd /home/hubot/myslackbot

export HUBOT_SLACK_TOKEN='12345'
export HUBOT_LOG_LEVEL='debug'
export PATH="/home/hubot/myslackbot/node_modules/.bin:/home/hubot/.nodebrew/current/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

sudo killall node

bin/hubot -a slack