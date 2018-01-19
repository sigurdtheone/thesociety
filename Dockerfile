FROM alpine:3.2  
MAINTAINER sigurd.kristensen@gmail.com

RUN apk update && apk --update add ruby ruby-irb ruby-json ruby-rake \  
    ruby-bigdecimal ruby-io-console libstdc++ tzdata nodejs libxml2-dev libxslt-dev

ADD Gemfile /app/  
ADD Gemfile.lock /app/

RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev \  
    libc-dev linux-headers && \
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
