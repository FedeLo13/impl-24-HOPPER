FROM ubuntu:latest

#Instalar dependencias
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
     git \
     sudo

#Instalar ruby
RUN sudo apt-get install -y ruby-full

#Instalar gemas
RUN gem install bundler && gem install sinatra && gem install rackup

WORKDIR /app

COPY appAbstraccion.rb /app/appAbstraccion.rb
COPY abstraccion.rb /app/abstraccion.rb
COPY views /app/views

CMD ["ruby", "appAbstraccion.rb","-o", "0.0.0.0"]