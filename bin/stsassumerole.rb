#!/usr/bin/env ruby
require 'fog'

aws_access_key_id = 'XXXXXXXXXXXXXXXXXX'
aws_secret_access_key = 'AXXZZZZZZZZZZZZZZZZZZ'
aws_region = 'us-west-2'

begin
  sts = Fog::AWS::STS.new(aws_access_key_id: aws_access_key_id, aws_secret_access_key: aws_secret_access_key)
rescue Exception => error
  puts error.inspect
  abort sts.inspect
end

begin
  response = sts.assume_role('MyRandomSession', 'arn:aws:iam::000000000000:role/STSAssumeRoleAccount')
rescue Exception => error
  puts error.inspect
  abort response.inspect
end

sts_aws_access_key_id = response.body['AccessKeyId']
sts_aws_secret_access_key = response.body['SecretAccessKey']
sts_session_token = response.body['SessionToken']

begin
  sts_connection = Fog::Compute.new(provider: 'AWS',
                                    region: aws_region,
                                    aws_session_token: sts_session_token,
                                    aws_access_key_id: sts_aws_access_key_id,
                                    aws_secret_access_key: sts_aws_secret_access_key)
rescue Exception => error
  puts error.inspect
  abort response.inspect
end

puts sts_connection.inspect
