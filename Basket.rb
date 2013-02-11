class Basket

  attr_accessor :line_items, :total
  attr_reader :store
  
  def initialize(store)
    @line_items = []
    @total = 0
    @store = store
  end

  def get_line_item_quantity(item_code)
    line_items.select { |i| i.code == item_code  }.count
  end

  def add_line_item(item_code)
    line_items << store.get_item(item_code)
  end

  def get_item_discount(item_code)
    rule = store.get_rule(item_code)
    if rule and get_line_item_quantity(item_code) >= rule.minimum_quantity
      return rule.discount
    else
      return 0
    end
  end

  def apply_final_discount_rule(current_total)
    final_discount_rule = store.get_rule('total')

    if final_discount_rule and current_total > final_discount_rule.minimum_quantity
      current_total -= current_total * final_discount_rule.discount/100
    end
    current_total
  end
  
  def empty
    self.line_items = []
    self.total = 0
  end
  
  def item_list
    return line_items.collect { |item| item.code }.join(", ")
  end

  def total
    current_total = 0
    line_items.uniq.each do |line_item|
      quantity = get_line_item_quantity(line_item.code)
      price = line_item.price - get_item_discount(line_item.code)
      current_total += quantity * price
    end
    apply_final_discount_rule(current_total)
  end

end
