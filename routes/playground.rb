# encoding: utf-8
class Optimaws < Sinatra::Application
  get '/playground/:region' do
    pass if request.path_info == '/playground/favicon.ico'
    @title = 'OptimAWS'
    @output   = EC2Compute.all(params[:region])
    @reserved = EC2Compute.reserved(params[:region])
    @loc      = params[:region]
    haml :playground
  end

  get '/playground' do
    pass if request.path_info == '/playground/favicon.ico'
    @title = 'OptimAWS'
    @output   = EC2Compute.all('us-west-2')
    @reserved = EC2Compute.reserved('us-west-2')
    @loc      = 'us-west-2'
    haml :playground
  end

  post '/playground' do
    @title = 'OptimAWS'
    @output   = EC2Compute.all(params[:region])
    @reserved = EC2Compute.reserved(params[:region])
    @loc      = params[:region]
    haml :playground
  end
end
