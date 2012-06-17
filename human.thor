#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'thor'
require 'twitter'

Twitter.configure do |config|
  config.consumer_key = ''
  config.consumer_secret = ''
  config.oauth_token = ''
  config.oauth_token_secret = ''
end

class Human < Thor
  desc 'tw [option]', 'tw is a Tweet from the Terminal.'
  option :onasui, :type => :boolean, :alias => '-o', :desc => 'You mutter a "おなかすいた"'
  def tw
    if options[ :onasui ]
      Twitter.update('おなかすいた')
    else
      Twitter.update(STDIN.gets)
    end
  end
end

Human.start
