module HashTree
  attr_accessor :hashtree
  def create
    Hash.new do |hash, key|
      hash[key] = @hashtree
    end
  end
  @hashtree
  module_function :create
end
