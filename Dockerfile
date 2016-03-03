# Build magento 2 from ubuntu base
FROM ubuntu:14.04.4

# Upate source file and install apache2, verify and start service.
RUN apt-get update \
        &&apt-get -y install apache2 \
        &&apache2 -v \
        &&a2enmod rewrite \
        &&service apache2 restart \
        &&cat <<EOF >> /etc/apache2/sites-available/000-default.conf\n\
<Directory "/var/www/html">\n\
        AllowOverride  <value from Apache site>\n\
</Directory>\n\
EOF\n\
#Solving 403 Forbidden errors for Apache 2.4
#        &&apt-get -y update \
# Upate source file and install php5 and required extensions, verify , update ini file and restart apache service.
        &&apt-get install software-properties-common -y \
        &&add-apt-repository -y -m ppa:ondrej/php5-5.6 \
#        &&apt-get -y update \
        &&apt-get -y install php5 php5-common php5-mcrypt php5-curl php5-cli php5-mysql php5-gd php5-intl php5-xsl \ 
#php5-bcmath not found but only required for enterprise edition
        &&php -v \
        &&sed -i '/.*date.timezone = .*/c\date.timezone = Australia\\/Melbourne' /etc/php5/apache2/php.ini \
        &&sed -i '/.*memory_limit = .*/c\memory_limit = 2G' /etc/php5/apache2/php.ini \
#        &&sed -i '/always_populate_raw_post_data/s/^#//g' /etc/php5/apache2/php.ini \
        &&sed -i '/.*always_populate_raw_post_data = .*/c\always_populate_raw_post_data = 1' /etc/php5/apache2/php.ini \
        &&sed -i '/.*asp_tags = .*/c\asp_tags = off' /etc/php5/apache2/php.ini \
#       Optional: Configure caching alternatives
#       session.save_handler
        &&service apache2 restart \
        
# start apache2 server at startup
CMD ["service apache2 start"]

# expose port 80 for web service
EXPOSE 80
