class DropNytfile < ActiveRecord::Migration
  def up
  	drop_table :nytfile
  end

  def down
  end
end
