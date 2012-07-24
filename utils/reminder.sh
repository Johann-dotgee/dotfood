#!/bin/sh
cd /var/www/app/rails/dotfood;
RAILS_ENV=production /usr/local/rvm/bin/dotfood_rails runner utils/reminder.rb
