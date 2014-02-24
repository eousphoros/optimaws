# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/apacsin' do
		@title = 'OptimAWS'
		haml :apacsin
	end
end
