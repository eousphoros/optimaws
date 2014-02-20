# encoding: utf-8
require 'amazon-pricing'
require 'yaml'

module CostComparison
  attr_accessor :ec2_pricing
  attr_accessor :result
  attr_accessor :allresult

  def hashtree
    Hash.new do |hash, key|
      hash[key] = hashtree
    end
  end

  @ec2_pricing = AwsPricing::Ec2PriceList.new

  def fetch(region, api_name, single)
    @result = hashtree
    instancetype = @ec2_pricing.get_instance_type(region, api_name)
    az = @ec2_pricing.get_region(region)
    loc = az.name
    pph = instancetype.price_per_hour(:linux, :ondemand)
    instancesize = instancetype.api_name

    unless pph.nil?
      year = pph * 8766

      @result['Ondemand'] = { hour: pph,
                              year: year.round(2) }
    end

    [:year1, :year3].each do |term|
      [:light, :medium, :heavy].each do |res_type|
        pphterm = instancetype.price_per_hour(:linux, res_type, term)

        unless pphterm.nil?

          hour = pphterm
          year = 0
          prepay = instancetype.prepay(:linux, res_type, term)
          yearprepay = prepay

          year = hour * 8766

          yearprepay = yearprepay + hour * 8766

          @result['Reserved'][term][res_type] = { hour: hour,
                                                  year: yearprepay.round(2),
                                                  prepay: prepay }
        end
      end
    end
    @result
  end

  def all
    @allresult = hashtree
    @ec2_pricing.regions.each do |region|
      region.ec2_instance_types.each do |instance|
        loc = region.name.to_s
        instancesize = instance.api_name.to_s
        @allresult[loc][instancesize] = fetch(loc, instancesize, single: 'false')
      end
    end
    @allresult
  end
module_function :hashtree
module_function :fetch
module_function :all
end
