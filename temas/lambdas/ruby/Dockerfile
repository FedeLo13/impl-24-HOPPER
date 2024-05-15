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
RUN gem install bundler && gem install sinatra && gem install rx && gem install rackup

WORKDIR /app

COPY appLambdas.rb /app/appLambdas.rb
COPY lambdas.rb /app/lambdas.rb
COPY views /app/views

CMD ["ruby", "appLambdas.rb","-o", "0.0.0.0"]