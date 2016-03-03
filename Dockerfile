FROM ubuntu:14.04.4
RUN apt-get update \
        &&apt-get -y install apache2 \
        &&apache2 -v \
        &&a2enmod rewrite \
        &&service apache2 restart \
        &&apt-get -y update \
        &&add-apt-repository ppa:ondrej/php5-5.6 \
        &&apt-get -y update \
        &&apt-get -y install php5 php5-mhash php5-mcrypt php5-curl php5-cli php5-mysql php5-gd php5-intl php5-xsl php
5-bcmath \
        &&php -v \
        &&sed -i '/always_populate_raw_post_data/s/^#//g' /etc/php5/apache2/php.ini \
        &&service apache2 restart \
CMD ["service apache2 start"]
EXPOSE 80
###pull test only
