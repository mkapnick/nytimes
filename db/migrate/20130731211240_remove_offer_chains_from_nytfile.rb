class RemoveOfferChainsFromNytfile < ActiveRecord::Migration
  def up
  	remove_column :nytfiles, :offer_chains_id
  end

  def down
  end

end
