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

  def get_graphs(type, region, term, util)
    util = util.gsub('Heavy Utilization', 'heavy')
    util = util.gsub('Medium Utilization', 'medium')
    util = util.gsub('Light Utilization', 'light')
    find = "#{get_region(region)}#{term}#{util}#{type.gsub('.', '')}.svg"
    searchdir = "#{Dir.pwd}/public/assets/"
    unless Dir.exists?(searchdir)
      return found = {}
    end
    Dir.chdir(searchdir)
    found = Dir.glob(find)
    Dir.chdir('../..')
    found
  end
  module_function :get_graphs
  module_function :get_region
end
