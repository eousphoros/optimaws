# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/useast' do
		@title = 'OptimAWS'
		haml :useast
	end
end
