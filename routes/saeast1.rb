# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/saeast1' do
		@title = 'OptimAWS'
		haml :saeast1
	end
end
