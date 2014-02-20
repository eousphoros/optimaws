# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/uswest' do
		@title = 'Optimaws'
		haml :uswest
	end
end
