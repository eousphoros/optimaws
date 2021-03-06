#!/usr/bin/env ruby

require 'fog'

compute = Fog::Compute.new(provider: 'AWS', use_iam_profile: true, region: ARGV[0])
result = compute.servers.all

result.each do |server|
    puts "#{server.id} #{server.security_group_ids}"
    server.tags.each do |key,value|
      puts "Tags: #{key} = #{value}" 
    end
end
