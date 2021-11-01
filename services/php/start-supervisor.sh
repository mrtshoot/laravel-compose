#!/usr/bin/env bash
crontab /etc/cron.d/laravel-schedule && service supervisor start && supervisorctl -c /etc/supervisor/supervisord.conf;
