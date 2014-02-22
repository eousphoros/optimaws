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
    puts "all #{region} called"
    serverinfo = hashtree
    return serverinfo unless RegionLookup.include?(region)
    compute = Fog::Compute.new(provider: 'AWS', use_iam_profile: true, region: region)
    result = compute.servers.all

    result.each do |server|
      serverid = server.id
      availabilityzone = server.availability_zone
      serverinfo[serverid]['instancetype'] = server.flavor_id
      serverinfo[serverid]['region'] = availabilityzone[0..-2]
      serverinfo[serverid]['availabilityzone'] = availabilityzone

      server.tags.sort.each do |key, tag|
        serverinfo[serverid]['tags'][key] = tag
      end

    end
    serverinfo
  end

  def reserved(region)
    puts "reserved #{region} called"
    reservedinfo = hashtree
    serverlist = EC2Compute.all(region)
    return reservedinfo unless RegionLookup.include?(region)
    compute = Fog::Compute.new(provider: 'AWS', use_iam_profile: true, region: region)
    reserved = compute.describe_reserved_instances

    reserved.body['reservedInstancesSet'].each do |key|
      unless key['reservedInstancesId'].nil?

        serverlist.each do |instance, values|
          if values['availabilityzone'] == key['availabilityZone'] && values['instancetype'] == key['instanceType'] && key['instanceCount'].to_i > 0
            key['instanceCount'] -= 1
            @reservedinstance = instance
          end
        end

        term = key['duration'].to_i / 2_628_000

        reservedinfo[key['reservedinstancesid']]['availabilityZone'] = key['availabilityZone']
        reservedinfo[key['reservedinstancesid']]['instanceType'] = key['instanceType']
        reservedinfo[key['reservedinstancesid']]['offeringType'] = key['offeringType']
        reservedinfo[key['reservedinstancesid']]['instanceCount'] = key['instanceCount']
        reservedinfo[key['reservedinstancesid']]['duration'] = term
        reservedinfo[key['reservedinstancesid']]['instanceid'] = @reservedinstance
      end
    end
    reservedinfo
  end
  module_function :all
  module_function :reserved
  module_function :hashtree
end
