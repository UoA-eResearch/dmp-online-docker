FROM            ubuntu:14.04
MAINTAINER      j.diprose@auckland.ac.nz

# Install dependencies
RUN             apt-get -y update
RUN             apt-get -y install software-properties-common
RUN             apt-add-repository ppa:brightbox/ruby-ng
RUN             apt-get -y update
RUN             apt-get -y install ruby2.1 ruby2.1-dev libmysqlclient-dev wkhtmltopdf git curl build-essential libcurl4-openssl-dev

# Get DMPonline
RUN             git clone https://github.com/DigitalCurationCentre/DMPonline_v4.git
WORKDIR         /DMPonline_v4/
RUN             git fetch --all
RUN             git checkout tags/V4.2

# Install Ruby Gems, Rails and Bundler
RUN             gem install rubygems-update
RUN             update_rubygems
RUN             gem update --system
RUN             gem install rails -v 3.2.15
RUN             gem install bundler


# Copy updated Gemfile across, fixes recaptcha bug
COPY            Gemfile Gemfile
RUN             bundle install

# Copy files across to fix broken database setup
COPY            config/database.yml config/database.yml
COPY            lib/patches/abstract_mysql_adapter.rb lib/patches/abstract_mysql_adapter.rb
COPY            config/environment.rb config/environment.rb
COPY            db/seeds.rb db/seeds.rb

CMD             ["/bin/bash"]

