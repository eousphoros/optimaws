# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/apactokyo' do
		@title = 'OptimAWS'
                @loc   = params[:url]
		haml :apactokyo
	end
end
