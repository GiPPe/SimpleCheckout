class Store

  attr_reader :items, :rules
  
  def initialize(product_table, rules_table)
    @items = {}
    @rules = {}

    product_table.each do |entry|
      if @items[entry[0]].nil?
        @items[entry[0]] = Item.new(entry[0], entry[1], entry[2])
      else
        puts "Item #{entry[0]} already in store"
      end
    end

    rules_table.each do |rule|
      add_rule(rule[0], rule[1], rule[2])           
    end
  end

  def get_item(item_code)
    items[item_code]
  end

  def get_rule(item_code)
    rules[item_code]
  end
  
  def add_rule(item_code, minimum_quantity, discount)
    if get_rule(item_code).nil?
      rules[item_code] = Rule.new(minimum_quantity, discount)
    else
      puts "Rule already exists for item #{item_code}"
    end
  end
  
  def update_rule(item_code, minimum_quantity, discount)
    rule = get_rule(item_code)
    if rule
      rule.minimum_quantity = minimum_quantity
      rule.discount = discount
    else
      puts "Rule does not exists for item #{item_code}"
    end
  end
  
  def remove_rule(item_code)
    rule = get_rule(item_code)
    if rule
      rules[item_code] = nil      
    else
      puts "Rule does not exists for item #{item_code}"
    end
  end
end
