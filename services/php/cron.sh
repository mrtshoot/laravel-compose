echo "Docker container has been started"
crontab /etc/cron.d/laravel-schedule
cron -f