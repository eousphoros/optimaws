# encoding: utf-8
class Optimaws < Sinatra::Application
	get '/apacsin' do
		@title = 'OptimAWS'
                @loc   = params[:url]
		haml :apacsin
	end
end
