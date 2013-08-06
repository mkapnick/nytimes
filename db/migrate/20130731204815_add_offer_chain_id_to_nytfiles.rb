class AddOfferChainIdToNytfiles < ActiveRecord::Migration
  def change
  	add_column :nytfiles, :offer_chain_id, :integer
  end
end
