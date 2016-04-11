FROM weepee-registry/php7-webserver

# php ini
COPY php.ini /etc/php7/php.ini

# Add clean wordpress
ADD wordpress /wordpress

# Auto install wordpress
ADD scripts/run.sh /scripts/run.sh

# Remove and mount attached storage
RUN rm -fr /app/* && chmod -R 755 /scripts && chmod a+rwx /app
