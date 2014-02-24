# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/useast' do
		@title = 'OptimAWS'
                @loc   = params[:url]
		haml :useast
	end
end
