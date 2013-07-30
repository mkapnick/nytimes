class CreateNytfiles < ActiveRecord::Migration
  def change
    create_table :nytfiles do |t|
      t.string :upload
      t.timestamps
    end
  end
end
