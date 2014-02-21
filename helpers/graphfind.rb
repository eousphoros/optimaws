#!/usr/bin/env ruby
# encoding: utf-8
require 'find'

module GraphFind
  REGION_LOOKUP = {
    'us-east-1'      => 'useast',
    'us-west-1'      => 'uswest',
    'us-west-2'      => 'uswest2',
    'eu-west-1'      => 'euireland',
    'ap-northeast-1' => 'apactokyo',
    'ap-southeast-1' => 'apacsin',
    'ap-southeast-2' => 'apacsyd',
    'sa-east-1'      => 'saeast1' }

  def get_region(name)
    REGION_LOOKUP[name] || name
  end

  def all(type, region)
    puts "#{type} #{region} called by GraphFind"
    find = "*#{get_region(region)}*#{type.gsub('.', '')}*"
    puts get_region(region)
    puts type.gsub('.', '')
    searchdir = "#{Dir.pwd}/public/assets/"
    puts searchdir
    unless Dir.exists?(searchdir)
      return found = {}
    end
    Dir.chdir(searchdir)
    found = Dir.glob(find)
    Dir.chdir('../..')
    found
  end
  module_function :all
  module_function :get_region
end
