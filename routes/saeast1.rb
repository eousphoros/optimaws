# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/saeast1' do
		@title = 'Optimaws'
		haml :saeast1
	end
end
