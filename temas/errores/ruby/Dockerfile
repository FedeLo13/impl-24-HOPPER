
FROM ubuntu:latest

# instalar dependencias
RUN apt-get update && apt-get install -y \
   build-essential \
   curl \
    git \
    sudo

# instalar ruby
RUN sudo apt-get install -y ruby-full

# instalar gemas
RUN gem install optional && gem install sinatra && gem install rackup

WORKDIR /app

COPY app.rb /app/app.rb
COPY calculator.rb /app/calculator.rb
COPY views /app/views

CMD ["ruby", "app.rb", "-o", "0.0.0.0"]