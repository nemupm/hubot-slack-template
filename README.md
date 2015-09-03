# How to use

1. exec 'docker build -t image_name ./' to make docker image
2. exec 'docker run --name container_name -i -t -d image_name'
3. exec 'docker exec -it container_name bash' to enter the container
4. edit /home/hubot/myslackbot/bin/run_hubot.sh to set environment variables(eg: TOKEN)
5. exec 'service supervisord on'
6. if you wanna add other hubot scripts, exec 'npm install <scripts> --save' and edit external-scripts.json)

# Log file

## /etc/supervisord.conf

```
logfile=/var/log/supervisor/hubot-slack/default.log
stdout_logfile=/var/log/supervisor/hubot-slack/stdout.log
stderr_logfile=/var/log/supervisor/hubot-slack/stderr.log
```
