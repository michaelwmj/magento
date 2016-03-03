FROM ubuntu:14.04.4
RUN apt-get update
CMD ["service apache2 start"]
EXPOSE 80
###pull test only
