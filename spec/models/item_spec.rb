require 'spec_helper'

describe Item do
  before(:each) do
    Item.create!({name: "Item1", category: "sports", tags: ["football", "arsenal"  ]})
    Item.create!({name: "Item2", category: "sports", tags: ["football", "chelsea"  ]})
    Item.create!({name: "Item3", category: "sports", tags: ["football", "liverpool"]})
  end
  
  it "should find some items in DB" do
    expect(Item.count).to eq(3)
  end

  it "should find item by tag" do
    expect(Item.with_tag("arsenal").length).to eq(1)
    expect(Item.with_tag("football").length).to eq(3)
  end
end
