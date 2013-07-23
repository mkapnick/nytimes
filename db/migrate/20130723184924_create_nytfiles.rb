class CreateNytfiles < ActiveRecord::Migration
  def change
    create_table :nytfiles do |t|
      t.string :uploads

      t.timestamps
    end
  end
end
