class ChangingRelationships < ActiveRecord::Migration
  def up
  end

  def down
  end

    def change 

    change_table :Tickets do |t|
    	t.references :OfferChain
    end
	end
end
