FROM ubuntu:16.04
MAINTAINER sigurd.kristensen@gmail.com
    
RUN apt-get update && apt-get install -y \ 
    ruby ruby-json rake libstdc++ tzdata nodejs \  
    libxml2-dev libxslt-dev libmysqlclient-dev

ADD Gemfile /app/  
ADD Gemfile.lock /app/

RUN apt-get install -y \
    ruby-dev openssl-dev linux-headers-generic && \
    gem install \
    bundler \
    unicorn && \
    cd /app ; bundle install --without development test && \
    apk del build-dependencies

ADD . /app  
RUN chown -R nobody:nogroup /app

RUN mkdir -p shared/pids shared/sockets shared/log

# Link persistant folders
RUN ln -s /data/files /app/public/files
RUN ln -s /data/images /app/public/images

USER nobody

ENV RAILS_ENV production
WORKDIR /app

EXPOSE 3080

CMD ["bundle", "exec", "unicorn", "-p", "3080", "-c", "./config/unicorn.rb"]