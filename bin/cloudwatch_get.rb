#!/usr/bin/env ruby

require 'fog'
require 'yaml'

cw_opts = {
  use_iam_profile: true,
  region: ARGV[0]
}

c_opts = {
  provider: 'AWS',
  use_iam_profile: true,
  region: ARGV[0]
}

cloudwatch = Fog::AWS::CloudWatch.new(cw_opts)
compute = Fog::Compute.new(c_opts)

result = compute.servers.all

result.each do |server|
  instanceId     = server.id
  puts instanceId
  metricList     = 'CPUUtilization', 'DiskReadBytes', 'DiskReadOps', 'DiskWriteBytes', 'DiskWriteOps', 'NetworkIn', 'NetworkOut', 'NumberOfMessagesPublished', 'NumberOfNotificationsDelivered', 'NumberOfNotificationsFailed', 'PublishSize', 'StatusCheckFailed', 'StatusCheckFailed_Instance', 'StatusCheckFailed_System', 'VolumeIdleTime', 'VolumeQueueLength', 'VolumeReadBytes', 'VolumeReadOps', 'VolumeTotalReadTime', 'VolumeTotalWriteTime', 'VolumeWriteBytes', 'VolumeWriteOps'
  namespace      = 'AWS/EC2'
  period         = 3600
  #unit           = 'Percent'
  statisticTypes = 'Maximum', 'Minimum', 'Average', 'SampleCount'

  startTime = (Time.now.gmtime-period).iso8601
  endTime  = Time.now.gmtime.iso8601

  puts "Start time #{startTime}"
  puts "End   time #{endTime}"

  metricList.each do |metric|
    puts metric
    resp = cloudwatch.get_metric_statistics(
              'Statistics' => statisticTypes,
              'StartTime'  => startTime,
              'EndTime'    => endTime,
              'Period'     => period,
  #            'Unit'       => unit,
              'MetricName' => metric,
              'Namespace'  => namespace,
              'Dimensions' => [{
         	                 'Name'  => 'InstanceId',
         	                 'Value' => instanceId
         			}]
                 ).body['GetMetricStatisticsResult']['Datapoints']
  
    puts resp.sort.inspect
  end
end
