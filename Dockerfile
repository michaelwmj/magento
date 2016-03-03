# Build magento 2 from ubuntu base
FROM ubuntu:14.04.4
# Upate source file and install apache2, verify and start service.
RUN apt-get update \
        &&apt-get -y install apache2 \
        &&apache2 -v \
        &&a2enmod rewrite \
        &&service apache2 restart \
        &&apt-get -y update \
# Upate source file and install php5 and required extensions, verify , update ini file and restart apache service.
        &&add-apt-repository -y ppa:ondrej/php5-5.6 \
        &&apt-get -y update \
        &&apt-get -y install php5 php5-common php5-mcrypt php5-curl php5-cli php5-mysql php5-gd php5-intl php5-xsl \ 
#php5-bcmath not find and only required for enterprise edition
        &&php -v \
        &&sed -i '/always_populate_raw_post_data/s/^#//g' /etc/php5/apache2/php.ini \
        &&service apache2 restart \
# start apache2 server at startup
CMD ["service apache2 start"]
# expose port 80 for web service
EXPOSE 80
