#!/usr/bin/env ruby

require 'fog'

compute = Fog::Compute.new(provider: 'AWS', use_iam_profile: true, region: ARGV[0])
result = compute.servers.all

result.each do |server|
    current_time = Time.now
    created_at = Time.parse(server.created_at.to_s)

    hours = (current_time.to_i - created_at.to_i) / 3600
    
    puts "#{server.id} almost_uptime: #{hours} hours"
    server.tags.each do |key,value|
      puts "Tags: #{key} = #{value}" 
    end
end
