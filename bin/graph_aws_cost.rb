#!/usr/bin/env ruby 

require 'amazon-pricing'

pricing = AwsPricing::Ec2PriceList.new

result =

pricing.regions.each do |region|
  region.ec2_instance_types.each do |t|
    [:year3, :year1].each do |term|
      [:light, :medium, :heavy].each do |res_type|

        if !t.price_per_hour(:linux, res_type, term).nil?
    
          holdme = t.price_per_hour(:linux, res_type, term)
          holdthis = 0
          firstyear = t.prepay(:linux, res_type, term)
    
          holdthis = holdme * 8766
    
          result = %x[/usr/bin/R --save < svg.R --args #{region.name} #{term} #{res_type} #{t.api_name} #{t.price_per_hour(:linux, :ondemand)} #{t.price_per_hour(:linux, res_type, term)} #{firstyear}]
         
        end
      end
    end
  end
end
