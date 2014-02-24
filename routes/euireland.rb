# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/euireland' do
		@title = 'OptimAWS'
		haml :euireland
	end
end
