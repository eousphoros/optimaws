# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/fail' do
          pass if request.path_info == '/playground/favicon.ico'
          @title = 'OptimAWS'
          @output   = "Oops! We are not sure what to do with that request."
          @loc      = 'Error'
          haml :fail
	end
end
