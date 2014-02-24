# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/apacsyd' do
		@title = 'OptimAWS'
		haml :apacsyd
	end
end
