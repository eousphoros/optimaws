# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/euireland' do
		@title = 'OptimAWS'
                @loc   = params[:url]
		haml :euireland
	end
end
