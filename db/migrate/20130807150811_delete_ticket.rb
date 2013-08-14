class DeleteTicket < ActiveRecord::Migration
  def up
  	drop_table :tickets
  end

  def down
  end
end
