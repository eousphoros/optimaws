# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/' do
          pass if request.path_info == '/playground/favicon.ico'
          @title      = 'OptimAWS'
          @compute    = EC2Compute.all('us-west-2')
          @reserved   = EC2Compute.reserved('us-west-2')
          @cloudwatch = CloudWatch.get_metrics('us-west-2')
          @loc        = 'us-west-2'
          haml :landing
	end
end
