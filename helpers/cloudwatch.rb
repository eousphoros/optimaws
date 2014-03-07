#!/usr/bin/env ruby
# encoding: utf-8

require 'fog'

module CloudWatch
  def hashtree
    Hash.new do |hash, key|
      hash[key] = hashtree
    end
  end

  def get_metrics(region)
    cw_metric = hashtree
    result = EC2Compute.all(region)

    unless result.nil?
      cloudwatch = Fog::AWS::CloudWatch.new(use_iam_profile: true, region: region)
      result.each do |server, value|
        instanceId     = server
        metricList     = 'CPUUtilization', 'DiskReadBytes', 'DiskReadOps', 'DiskWriteBytes', 'DiskWriteOps', 'NetworkIn', 'NetworkOut', 'NumberOfMessagesPublished', 'NumberOfNotificationsDelivered', 'NumberOfNotificationsFailed', 'PublishSize', 'StatusCheckFailed', 'StatusCheckFailed_Instance', 'StatusCheckFailed_System', 'VolumeIdleTime', 'VolumeQueueLength', 'VolumeReadBytes', 'VolumeReadOps', 'VolumeTotalReadTime', 'VolumeTotalWriteTime', 'VolumeWriteBytes', 'VolumeWriteOps'
        namespace      = 'AWS/EC2'
        period         = 3600
        statisticTypes = 'Maximum', 'Minimum', 'Average', 'SampleCount'

        startTime = (Time.now.gmtime - period).iso8601
        endTime  = Time.now.gmtime.iso8601

        metricList.each do |metric|
          cw_metric[instanceId][metric] = cloudwatch.get_metric_statistics(
            'Statistics' =>  statisticTypes,
            'StartTime' =>   startTime,
            'EndTime' =>     endTime,
            'Period' =>      period,
            'MetricName' =>  metric,
            'Namespace' =>   namespace,
            'Dimensions' =>  [{
              'Name' =>  'InstanceId',
              'Value' => instanceId
            }]).body['GetMetricStatisticsResult']['Datapoints']
        end
      end
      cw_metric
    end
  end
  module_function :get_metrics
  module_function :hashtree
end
