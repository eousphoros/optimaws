# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/apacsyd' do
		@title = 'Optimaws'
		haml :apacsyd
	end
end
