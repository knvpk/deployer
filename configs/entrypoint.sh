#!/bin/bash
set -e


APP_ENV=${APP_ENV:-production}
APP_DEBUG=${APP_DEBUG:-false}
APP_URL=${APP_URL:-http://localhost}
APP_KEY=${APP_KEY:-SECRET}
APP_TIMEZONE=${APP_TIMEZONE:-Europe/London}
APP_LOCALE=${APP_LOCALE:-en}
APP_THEME=${APP_THEME:-green}
APP_LOG=${APP_LOG:-daily}

JWT_SECRET=${JWT_SECRET:-changeme}


SOCKET_URL=${SOCKET_URL:-http://deploy.app}
SOCKET_PORT=${SOCKET_PORT:-6001}
SOCKET_SSL_KEY_FILE=${SOCKET_SSL_KEY_FILE:-null}
SOCKET_SSL_CERT_FILE=${SOCKET_SSL_CERT_FILE:-null}
SOCKET_SSL_CA_FILE=${SOCKET_SSL_CA_FILE:-null}

DB_TYPE=${DB_TYPE:-mysql}
DB_HOST=${DB_HOST:-localhost}
DB_DATABASE=${DB_DATABASE:-deloyer}
DB_USERNAME=${DB_USERNAME:-homestead}
DB_PASSWORD=${DB_PASSWORD:-secret}


MAIL_DRIVER=${MAIL_DRIVER:-smtp}
MAIL_HOST=${MAIL_HOST:-mailtrap.io}
MAIL_PORT=${MAIL_PORT:-25}
MAIL_USERNAME=${MAIL_USERNAME:-homestead}
MAIL_PASSWORD=${MAIL_PASSWORD:-secret}
MAIL_FROM_ADDRESS=${MAIL_FROM_ADDRESS:-deployer@deploy.app}
MAIL_FROM_NAME=${MAIL_FROM_NAME:-Deployer}

CACHE_DRIVER=${CACHE_DRIVER:-file}
SESSION_DRIVER=${SESSION_DRIVER:-file}
QUEUE_DRIVER=${QUEUE_DRIVER:-beanstalkd}
QUEUE_HOST=${QUEUE_HOST:-localhost}

IMAGE_DRIVER=${IMAGE_DRIVER:-gd}

GITHUB_OAUTH_TOKEN=${GITHUB_OAUTH_TOKEN:-null}

REDIS_HOST=${REDIS_HOST:-127.0.0.1}
REDIS_DATABASE=${REDIS_DATABASE:-null}
REDIS_PORT=${REDIS_PORT:-6379}

# configure env file

sed 's,{{APP_ENV}},'"${APP_ENV}"',g' -i /var/www/deployer/.env
sed 's,{{APP_DEBUG}},'"${APP_DEBUG}"',g' -i /var/www/deployer/.env
sed 's,{{APP_URL}},'"${APP_URL}"',g' -i /var/www/deployer/.env
sed 's,{{APP_KEY}},'"${APP_KEY}"',g' -i /var/www/deployer/.env
sed 's,{{APP_TIMEZONE}},'"${APP_TIMEZONE}"',g' -i /var/www/deployer/.env
sed 's,{{APP_LOCALE}},'"${APP_LOCALE}"',g' -i /var/www/deployer/.env
sed 's,{{APP_THEME}},'"${APP_THEME}"',g' -i /var/www/deployer/.env
sed 's,{{APP_LOG}},'"${APP_LOG}"',g' -i /var/www/deployer/.env

sed 's,{{JWT_SECRET}},'"${JWT_SECRET}"',g' -i /var/www/deployer/.env

sed 's,{{SOCKET_URL}},'"${SOCKET_URL}"',g' -i /var/www/deployer/.env
sed 's,{{SOCKET_PORT}},'"${SOCKET_PORT}"',g' -i /var/www/deployer/.env
sed 's,{{SOCKET_SSL_KEY_FILE}},'"${SOCKET_SSL_KEY_FILE}"',g' -i /var/www/deployer/.env
sed 's,{{SOCKET_SSL_CERT_FILE}},'"${SOCKET_SSL_CERT_FILE}"',g' -i /var/www/deployer/.env
sed 's,{{SOCKET_SSL_CA_FILE}},'"${SOCKET_SSL_CA_FILE}"',g' -i /var/www/deployer/.env


sed 's,{{DB_TYPE}},'"${DB_TYPE}"',g' -i /var/www/deployer/.env
sed 's,{{DB_HOST}},'"${DB_HOST}"',g' -i /var/www/deployer/.env
sed 's,{{DB_DATABASE}},'"${DB_DATABASE}"',g' -i /var/www/deployer/.env
sed 's,{{DB_USERNAME}},'"${DB_USERNAME}"',g' -i /var/www/deployer/.env
sed 's,{{DB_PASSWORD}},'"${DB_PASSWORD}"',g' -i /var/www/deployer/.env

sed 's,{{CACHE_DRIVER}},'"${CACHE_DRIVER}"',g' -i /var/www/deployer/.env
sed 's,{{SESSION_DRIVER}},'"${SESSION_DRIVER}"',g' -i /var/www/deployer/.env
sed 's,{{QUEUE_DRIVER}},'"${QUEUE_DRIVER}"',g' -i /var/www/deployer/.env
sed 's,{{QUEUE_HOST}},'"${QUEUE_HOST}"',g' -i /var/www/deployer/.env

sed 's,{{MAIL_DRIVER}},'"${MAIL_DRIVER}"',g' -i /var/www/deployer/.env
sed 's,{{MAIL_HOST}},'"${MAIL_HOST}"',g' -i /var/www/deployer/.env
sed 's,{{MAIL_PORT}},'"${MAIL_PORT}"',g' -i /var/www/deployer/.env
sed 's,{{MAIL_USERNAME}},'"${MAIL_USERNAME}"',g' -i /var/www/deployer/.env
sed 's,{{MAIL_PASSWORD}},'"${MAIL_PASSWORD}"',g' -i /var/www/deployer/.env
sed 's,{{MAIL_FROM_ADDRESS}},'"${MAIL_FROM_ADDRESS}"',g' -i /var/www/deployer/.env
sed 's,{{MAIL_FROM_NAME}},'"${MAIL_FROM_NAME}"',g' -i /var/www/deployer/.env

sed 's,{{REDIS_HOST}},'"${REDIS_HOST}"',g' -i /var/www/deployer/.env
sed 's,{{REDIS_DATABASE}},'"${REDIS_DATABASE}"',g' -i /var/www/deployer/.env
sed 's,{{REDIS_PORT}},'"${REDIS_PORT}"',g' -i /var/www/deployer/.env

sed 's,{{IMAGE_DRIVER}},'"${IMAGE_DRIVER}"',g' -i /var/www/deployer/.env

sed 's,{{GITHUB_OAUTH_TOKEN}},'"${GITHUB_OAUTH_TOKEN}"',g' -i /var/www/deployer/.env


php composer.phar install --no-dev -o

echo "Starting supervisord..."
exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf

exit 0
