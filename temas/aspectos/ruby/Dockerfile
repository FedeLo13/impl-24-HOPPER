FROM ubuntu:latest

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
     git \
     sudo

#Instalar ruby
RUN sudo apt-get install -y ruby-full

#Instalar gemas
RUN gem install bundler && gem install sinatra && gem install aquarium && gem install rackup

WORKDIR /app

COPY appAspectos.rb /app/appAspectos.rb
COPY aspectos.rb /app/aspectos.rb
COPY views /app/views

CMD ["ruby", "appAspectos.rb","-o", "0.0.0.0"]