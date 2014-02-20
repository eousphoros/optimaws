require 'sinatra/json'

get '/ec2costs/:region/:api_name', provides: :json do
  json CostComparison.fetch(params[:region], params[:api_name], single: 'true')
end

get '/ec2costs', provides: :json do
  json CostComparison.all
end

post '/ec2costs', provides: :json do
  json CostComparison.fetch(params[:region], params[:api_name], single: 'true')
end
