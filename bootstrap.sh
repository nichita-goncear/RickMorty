#!/bin/sh

echo "Checking for homebrew updates..";
brew update

if [ -e "Gemfile" ]; then
  echo "Installing ruby gems";

  gem install bundler --no-document || echo "Failed to install bundle..";
  bundle config set deployment 'true';
  bundle config path Vendor/Bundle;
  bundle install || echo "Failed to install bundle..";
fi