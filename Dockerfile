FROM ubuntu:16.04
MAINTAINER sigurd.kristensen@gmail.com

ENV DEBIAN_FRONTEND noninteractive
    
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN apt-get install -y --no-install-recommends libmagickwand-dev \ 
    ruby ruby-kgio ruby-json rake tzdata nodejs imagemagick \  
    build-essential libxml2-dev libxslt-dev libmysqlclient-dev

ADD Gemfile /app/  
ADD Gemfile.lock /app/

RUN apt-get install -y \
    ruby-dev openssl linux-headers-generic && \
    gem install \
    bundler \
    unicorn && \
    cd /app ; bundle install --without development test && \
    apt-get purge -y build-essential

ADD . /app  

RUN mkdir -p /app/shared/pids /app/shared/sockets /app/shared/log

RUN chown -R nobody:nogroup /app

# Link persistant folders
RUN ln -s /data/files /app/public/files
RUN ln -s /data/images /app/public/images

USER nobody

ENV RAILS_ENV production
WORKDIR /app

EXPOSE 3080

CMD ["bundle", "exec", "unicorn", "-p", "3080", "-c", "./config/unicorn.rb"]
