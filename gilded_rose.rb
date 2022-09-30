class GildedRose

  def initialize(items)
    @items = items.map do |item|
      case item.name
      when "Sulfuras, Hand of Ragnaros"
        Sulfuras.new(item)
      when "Backstage passes to a TAFKAL80ETC concert"
        BackstagePass.new(item)
      when "Aged Brie"
        AgedBrie.new(item)
      when "Conjured"
        ConjuredItem.new(item)
      else
        CommonItem.new(item)
      end
    end
  end

  def update_quality()
    @items.each do |item|
      item.update
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class CommonItem < Item
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def update
    if(item.sell_in > 0)
      item.quality = change_quality(item, -1)
    else
      item.quality = change_quality(item, -2)
    end
  end

  def change_quality(item, value)
    if item.quality + value >= 50
      return 50
    elsif item.quality + value <= 0
      return 0
    else
      return item.quality + value
    end
  end
end

class AgedBrie < CommonItem

  def update
    item.quality = change_quality(item, 1)
  end
end

class Sulfuras < CommonItem

  def update
  end
end

class BackstagePass < CommonItem

  def update
    if item.sell_in <= 0
      item.quality = 0
    elsif item.sell_in <= 5
      item.quality = change_quality(item, 3)
    elsif item.sell_in <= 10
      item.quality = change_quality(item, 2)
    else
      item.quality = change_quality(item, 1)
    end
  end
end

class ConjuredItem < CommonItem

  def update
    item.quality = change_quality(item, -2)
  end
end
