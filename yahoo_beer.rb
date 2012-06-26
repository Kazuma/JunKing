#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'nokogiri'
require 'open-uri'

# 今日のビール指数取ってくる
puts Nokogiri::HTML(open('http://weather.yahoo.co.jp/weather/jp/expo/beer/47/9110.html')).xpath('//tr[3]/td/small').first.text.strip
