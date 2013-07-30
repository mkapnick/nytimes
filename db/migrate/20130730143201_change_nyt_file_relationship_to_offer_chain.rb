class ChangeNytFileRelationshipToOfferChain < ActiveRecord::Migration
  def up
  end

  def down
  end

  def change 
	change_table :Nytfiles do |t|
  	t.references :OfferChain
  end
	end
end
