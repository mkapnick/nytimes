class AddAttributeNameToNytfile < ActiveRecord::Migration
  def change
  	add_column :nytfiles, :name, :string
  end
end
