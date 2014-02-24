# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/saeast1' do
		@title = 'OptimAWS'
                @loc   = params[:url]
		haml :saeast1
	end
end
