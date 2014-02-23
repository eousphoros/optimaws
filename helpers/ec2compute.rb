#!/usr/bin/env ruby
# encoding: utf-8
require 'fog'

module EC2Compute
  REGION_LOOKUP = Set[
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
    return serverinfo unless REGION_LOOKUP.include?(region)

    compute = Fog::Compute.new(provider: 'AWS', use_iam_profile: true, region: region)

    result = compute.servers.all
    serverinfo = hashtree

    result.each do |server|
      if server.state.to_s == 'running'
        serverid = server.id
        availabilityzone = server.availability_zone
        serverinfo[serverid]['instancetype'] = server.flavor_id
        serverinfo[serverid]['region'] = availabilityzone[0..-2]
        serverinfo[serverid]['availabilityzone'] = availabilityzone

        server.tags.sort.each do |key, tag|
          serverinfo[serverid]['tags'][key] = tag
        end
      end
    end
    serverinfo
  end

  def assign_reserved(key, reservedinfo, region)
    serverlist = EC2Compute.all(region)

    serverlist.each do |instance, values|
#      reservedinfo[key['reservedInstancesId']]['instanceid'] = 'Unused'
      if values['availabilityzone'] == key['availabilityZone'] && values['instancetype'] == key['instanceType']
        key['instanceCount'] -= 1
        reservedinfo[key['reservedInstancesId']]['instanceid'] = instance
      end
    end
    reservedinfo
  end

  def reserved(region)
    return reservedinfo unless REGION_LOOKUP.include?(region)

    compute = Fog::Compute.new(provider: 'AWS', use_iam_profile: true, region: region)
    reserved = compute.describe_reserved_instances
    reservedinfo = hashtree
    puts reserved.inspect

    reserved.body['reservedInstancesSet'].each do |key|
      unless key['reservedInstancesId'].nil? || key['instanceCount'].to_i <= 0
        if key['state'].to_s == 'active'

          term = ((key['duration'].to_i / 2_628_000).to_f / 12).ceil

          reservedinfo[key['reservedInstancesId']]['availabilityZone'] = key['availabilityZone']
          reservedinfo[key['reservedInstancesId']]['instanceType'] = key['instanceType']
          reservedinfo[key['reservedInstancesId']]['offeringType'] = key['offeringType']
          reservedinfo[key['reservedInstancesId']]['instanceCount'] = key['instanceCount']
          reservedinfo[key['reservedInstancesId']]['duration'] = term
          reservedinfo = EC2Compute.assign_reserved(key, reservedinfo, region)
        end
      end
    end
    reservedinfo
  end
  module_function :all
  module_function :reserved
  module_function :assign_reserved
  module_function :hashtree
end
