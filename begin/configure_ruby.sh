#!/bin/bash

# target ruby version
RUBY_VERSION=2.4.1

# install ruby
rbenv install --verbose $RUBY_VERSION
rbenv global $RUBY_VERSION

# install hanami
gem install hanami

echo "ruby '$RUBY_VERSION'" >> Gemfile && bundle

hanami db prepare