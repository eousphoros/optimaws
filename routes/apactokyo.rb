# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/apactokyo' do
		@title = 'OptimAWS'
		haml :apactokyo
	end
end
