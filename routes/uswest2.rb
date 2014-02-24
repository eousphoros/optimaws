# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/uswest2' do
		@title = 'OptimAWS'
                @loc   = params[:url]
		haml :uswest2
	end
end
