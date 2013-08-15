class Changeshit < ActiveRecord::Migration
  def up
  end

  def down
  end

    def change
   create_table :offer_chains do |t|
      t.string :approved
      t.string :date
      t.timestamps
    end
 	drop_table :nytfiles
    create_table :nytfiles do |t|
      t.string :upload
      t.belongs_to :offer_chains
      t.timestamps
    end
end
end
