# encoding: utf-8
class Checkout

  attr_reader :basket, :store
    
  def initialize( promotional_rules )
    product_table = promotional_rules[0]
    rules_table = promotional_rules[1]

    @store = Store.new(product_table, rules_table)
    @basket = Basket.new(@store)
  end

  def scan( item_code )    
    basket.add_line_item(item_code)
  end

  def total
    basket.total.round(2)    
  end

  def print_receipt
    puts "\nBasket: " + basket.item_list
    puts "Price: £" + total.to_s    
  end

end
