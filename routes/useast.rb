# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/useast' do
		@title = 'Optimaws'
		haml :useast
	end
end
