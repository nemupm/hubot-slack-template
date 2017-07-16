# hubot-slack-template

Dockerfile for hubot with slack.

# Plugins

* hubot-help
* hubot-google-translate
* hubot-google-images
* hubot-pugme
* hubot-maps
* hubot-youtube
* hubot-docomo-dialog

# Usage

```
$ docker build https://github.com/nemupm/hubot-slack-template.git#master --tag hubot-image
$ docker run --rm \
    -e HUBOT_SLACK_TOKEN=XXXXXXXXXX \
    -e DOCOMO_API_KEY=XXXXXXXXXX \
    -e CHARACTER_TYPE=20 \
    hubot-image
```

