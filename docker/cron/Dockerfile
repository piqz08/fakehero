FROM php:7.4-fpm-alpine

RUN echo "* * * * * cd /var/www/ritsuan-laravel && php artisan schedule:run >> /dev/null 2>&1" >> /etc/crontabs/root
RUN printf '[PHP]\ndate.timezone = "Asia/Tokyo"\n' > /usr/local/etc/php/conf.d/tzone.ini
COPY --chown=www-data:www-data ./src/ritsuan-laravel /var/www/ritsuan-laravel
RUN touch /run/supervisord.sock
COPY ./docker/cron/conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./docker/cron/scripts/configure.sh /configure.sh
RUN ["chmod", "+x", "/configure.sh"]
CMD /configure.sh
