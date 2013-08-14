class CreateTableTicketAgain < ActiveRecord::Migration
  def up
    drop_table :tickets
  	create_table :tickets do |t|
      t.string :summary
      t.string :description
      t.references :offerchain
 
      t.timestamps
  	end
  end

  def down
  	drop_table :tickets
  end
end
