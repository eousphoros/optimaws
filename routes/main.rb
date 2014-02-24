# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/' do
          pass if request.path_info == '/playground/favicon.ico'
          @title = 'OptimAWS'
          @output   = EC2Compute.all('us-west-2')
          @reserved = EC2Compute.reserved('us-west-2')
          @loc      = 'us-west-2'
          haml :playground
	end
end
