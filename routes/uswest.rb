# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/uswest' do
		@title = 'OptimAWS'
                @loc   = params[:url]
		haml :uswest
	end
end
