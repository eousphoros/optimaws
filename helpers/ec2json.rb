# encoding: utf-8
require 'amazon-pricing'
require 'yaml'

module EC2CostComparison
  def hashtree
    Hash.new do |hash, key|
      hash[key] = hashtree
    end
  end

  def initialize
    pricing = AwsPricing::Ec2PriceList.new
    pricing
  end

  def fetch(region, instancetype)
    pph = instancetype.price_per_hour(:linux, :ondemand)
    az = region.name
    instancesize = instancetype.api_name

    unless pph.nil?

      year = pph * 8766

      result['Ondemand'][az][instancesize] = { hour: pph,
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

          result['Reserved'][az][instancesize][term][res_type] = { hour: hour,
                                                                   year: yearprepay.round(2),
                                                                   prepay: prepay }
          return result
        end
      end
    end

    def all
      pricing.regions.each do |region|
        region.ec2_instance_types.each do |instancetype|
          fetch(region, instancetype)
        end
      end
    end

    result
  end

  module_function :fetch
  module_function :fetch.all
  module_function :hashtree
  module_function :new
end
