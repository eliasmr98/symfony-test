#!/bin/sh
set -e

if [ "$1" = 'frankenphp' ] || [ "$1" = 'php' ] || [ "$1" = 'bin/console' ]; then

	if [ -z "$(ls -A 'vendor/' 2>/dev/null)" ]; then
		composer install --prefer-dist --no-progress --no-interaction
	fi

	setfacl -R -m u:www-data:rwX -m u:"$(whoami)":rwX var
	setfacl -dR -m u:www-data:rwX -m u:"$(whoami)":rwX var

	echo 'PHP app ready!'
fi

git config --local core.hooksPath .githooks/

if [ "$APP_ENV" != 'local' ]; then
    if [ -f /var/run/supervisord.pid ]; then
        echo "Starting supervisord to manage processes..."
        /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
    else
        echo "Supervisord PID file not found. Skipping supervisord startup."
    fi
fi

exec docker-php-entrypoint "$@"
