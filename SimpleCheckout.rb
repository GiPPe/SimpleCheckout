# encoding: utf-8
Dir["./*.rb"].each {|file| require file if file != "./SimpleCheckout.rb" }

class SimpleCheckout

  product_codes = ['001', '002', '003']
  product_names = ['a', 'b', 'c']
  product_prices = [9.25, 45, 19.95]

  product_table = product_codes.zip(product_names, product_prices)

  rule_table = []
  rule_table << ['total', 60, 10]
  rule_table << ['001', 2, 0.75]

  promotional_rules = [product_table, rule_table]

  carts = [ ['001', '002', '003'],
            ['001', '003', '001'],
            ['001', '002', '001', '003'] ]
            
  co = Checkout.new(promotional_rules)
          
  carts.each do |cart|
    cart.each do |item_code|
      co.scan(item_code)
    end
    price = co.total
    co.print_receipt
    co.basket.empty
  end

end
