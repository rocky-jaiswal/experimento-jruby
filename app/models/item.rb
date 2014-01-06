class Item < ActiveRecord::Base

  scope :with_tag, ->(tag){ Item.all.select{|i| i.tags.include?(tag)}}

end
