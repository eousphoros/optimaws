module HashTree
  def new(hashtree)
    Hash.new do |hash, key|
      hash[key] = hashtree
    end
  end
  module_function :new
end
