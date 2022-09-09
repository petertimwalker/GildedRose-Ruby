require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "Quality degrades normally" do
      items = [Item.new("foo", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 9
    end

    it "Once the sell by date has passed, Quality degrades twice as fast" do
      items = [Item.new("foo", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end

    it "The Quality of an item is never negative" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "Aged Brie actually increases in Quality the older it gets" do
      items = [Item.new("Aged Brie", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to be > 10
    end

    it "The Quality of an item is never more than 50" do
      items = [Item.new("Aged Brie", 10, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "Sulfuras, being a legendary item, never has to be sold or decreases in Quality" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 80
    end

    it "Backstage passes, Quality drops to 0 after the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "Backstage passes, Quality increases by 2 when there are 10 days or less" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 12
    end

    it "Backstage passes, Quality increases by 3 when there are 5 days or less" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 13
    end

    it "Conjured items degrade in Quality twice as fast as normal items" do
      items = [Item.new("Conjured", 5, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end

  end



end
