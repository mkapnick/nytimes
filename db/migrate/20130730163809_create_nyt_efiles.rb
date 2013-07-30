class CreateNytEfiles < ActiveRecord::Migration
  def change
    create_table :nyt_efiles do |t|
      t.string :upload

      t.timestamps
    end
  end
end
