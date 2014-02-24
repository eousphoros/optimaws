# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/fail' do
          pass if request.path_info == '/playground/favicon.ico'
          @title = 'OptimAWS'
          @output   = "I'm sorry, but I don't understand the request"
          @loc      = 'Error'
          haml :fail
	end
end
