# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/apacsin' do
		@title = 'Optimaws'
		haml :apacsin
	end
end
