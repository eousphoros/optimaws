# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/cloudwatch' do
          pass if request.path_info == '/playground/favicon.ico'
          @title = 'OptimAWS'
          @output   = CloudWatch.get_metrics('us-west-2')
          @loc      = 'us-west-2'
          haml :cloudwatch
	end
end
