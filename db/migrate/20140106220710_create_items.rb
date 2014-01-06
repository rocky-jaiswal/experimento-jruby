class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :category
      t.text :tags, :array => true, :default => '{}'

      t.timestamps
    end
  end
end
