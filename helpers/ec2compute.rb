#!/usr/bin/env ruby
# encoding: utf-8
require 'fog'

module EC2Compute
  RegionLookup = Set[
    'us-east-1',
    'us-west-1',
    'us-west-2',
    'eu-west-1',
    'ap-northeast-1',
    'ap-southeast-1',
    'ap-southeast-2',
    'sa-east-1']

  def hashtree
    Hash.new do |hash, key|
      hash[key] = hashtree
    end
  end

  def all(region)
    puts "#{region} called by playground"
    serverinfo = hashtree
    return serverinfo unless RegionLookup.include?(region)
    compute = Fog::Compute.new(provider: 'AWS', use_iam_profile: true, region: region)
    result = compute.servers.all

    result.each do |server|
       serverid = server.id
       serverinfo[serverid]['instancetype'] = server.flavor_id
       serverinfo[serverid]['region'] = server.availability_zone[0..-2]
       server.tags.each do |key, tag|
         serverinfo[serverid]['tags'][key] = tag
       end
    end
    serverinfo
  end

  def reserved(region)
    puts "#{region} called by playground"
    reservedinfo = hashtree
    return reservedinfo unless RegionLookup.include?(region)
    compute = Fog::Compute.new(provider: 'AWS', use_iam_profile: true, region: region)
    reserved = compute.describe_reserved_instances

    reserved.body['reservedInstancesSet'].each do |key|
      term = key['duration'].to_i / 2_628_000
      reservedinfo[reservedInstanceId: key['reservedInstancesId']] = {
                                    availabilityZone: key['availabilityZone'],
                                    instanceType: key['instanceType'],
                                    offeringType: key['offeringType'],
                                    instanceCount: key['instanceCount'],
                                    duration: term }
    end
    reservedinfo
  end
  module_function :all
  module_function :reserved
  module_function :hashtree
end
