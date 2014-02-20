# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/euireland' do
		@title = 'Optimaws'
		haml :euireland
	end
end
