# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/apacsyd' do
		@title = 'OptimAWS'
                @loc   = params[:url]
		haml :apacsyd
	end
end
