class DropNytfiles < ActiveRecord::Migration
  def up
  	drop_table :nytfiles
  end

  def down
  end
end
