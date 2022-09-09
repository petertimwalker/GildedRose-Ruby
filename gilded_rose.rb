class GildedRose

  def initialize(items)
    @items = items
  end

  # Represents a day passing
  def update_quality_old()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when "Sulfuras, Hand of Ragnaros"
        return
      when "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in <= 0
          item.quality = 0
        elsif item.sell_in <= 5
          item.quality = change_quality(item, 3)
        elsif item.sell_in <= 10
          item.quality = change_quality(item, 2)
        else
          item.quality = change_quality(item, 1)
        end
      when "Aged Brie"
        item.quality = change_quality(item, 1)
      when "Conjured"
        item.quality = change_quality(item, -2)
      else
        if item.sell_in > 0
          item.quality = change_quality(item, -1)
        else
          item.quality = change_quality(item, -2)
        end
      end
    end
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
