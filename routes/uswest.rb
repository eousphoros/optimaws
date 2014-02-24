# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/uswest' do
		@title = 'OptimAWS'
		haml :uswest
	end
end
