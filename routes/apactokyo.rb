# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/apactokyo' do
		@title = 'Optimaws'
		haml :apactokyo
	end
end
