# encoding: utf-8
class Optimaws < Sinatra::Application
  get '/graphfind/:region/:type' do
    pass if request.path_info =~ /favicon/
    @title = 'OptimAWS'
    @output = GraphFind.all(params[:type], params[:region])
    haml :graphfind
  end

  get '/graphfind' do
    @title = 'OptimAWS'
    @output = 'Please specify an instance class and region'
    haml :main
  end

  post '/graphfind' do
    @title = 'OptimAWS'
    @output = GraphFind.all(params[:type], params[:region])
    haml :graphfind
  end
end
