#!/usr/bin/env ruby
# encoding: utf-8
require 'find'

module GraphFind
  RegionLookup = {
    'us-east-1'      => 'useast',
    'us-west-1'      => 'uswest',
    'us-west-2'      => 'uswest2',
    'eu-west-1'      => 'euireland',
    'ap-northeast-1' => 'apactokyo',
    'ap-southeast-1' => 'apacsin',
    'ap-southeast-2' => 'apacsyd',
    'sa-east-1'      => 'saeast1' }

  def get_region(name)
    RegionLookup[name] || name
  end

  def all(type, region)
    puts "#{type} #{region} called by GraphFind"
    find = "*#{get_region(region)}*#{type.gsub('.', '')}*"
    puts get_region(region)
    puts type.gsub('.', '')
    Dir.chdir('/opt/nginx/html/optimaws/current/public/assets/')
    found = Dir.glob(find)
    found
  end
  module_function :all
  module_function :get_region
end
