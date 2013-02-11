class Rule

  attr_accessor :minimum_quantity, :discount
  
  def initialize(minimum_quantity, discount)
    @minimum_quantity = minimum_quantity
    @discount = discount
  end

end