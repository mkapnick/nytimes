class ChangeRelationshipCorrectly < ActiveRecord::Migration
  def up
  end

  def down
  end

  def change
   drop_table :offer_chains
   create_table :offer_chain do |t|
      t.string :approved
      t.string :date
      t.timestamps
    end
 	drop_table :nyt_efiles
    create_table :nytfile do |t|
      t.string :upload
      t.belongs_to :offer_chain
      t.timestamps
    end
end
end
