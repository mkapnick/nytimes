class AddAttributeToTicket < ActiveRecord::Migration
  def change
  	add_column :tickets, :summary, :string
  end
end
