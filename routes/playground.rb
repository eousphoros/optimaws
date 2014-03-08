# encoding: utf-8
class Optimaws < Sinatra::Application
  get '/playground/:region' do
    pass if request.path_info == '/playground/favicon.ico'
    @title    = 'OptimAWS'
    @compute  = EC2Compute.all(params[:region])
    @reserved = EC2Compute.reserved(params[:region])
    @cloudwatch = CloudWatch.get_metrics(params[:region])
    @loc      = params[:region]
    haml :playground
  end

  get '/playground' do
    pass if request.path_info == '/playground/favicon.ico'
    @title      = 'OptimAWS'
    @compute    = EC2Compute.all('us-west-2')
    @reserved   = EC2Compute.reserved('us-west-2')
    @cloudwatch = CloudWatch.get_metrics('us-west-2')
    @loc        = 'us-west-2'
    haml :playground
  end

  post '/playground' do
    @title    = 'OptimAWS'
    @compute  = EC2Compute.all(params[:region])
    @reserved = EC2Compute.reserved(params[:region])
    @cloudwatch = CloudWatch.get_metrics(params[:region])
    @loc      = params[:region]
    haml :playground
  end
end
