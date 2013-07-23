class CreateOfferChains < ActiveRecord::Migration
  def change
    create_table :offer_chains do |t|
      t.string :date
      t.string :approved

      t.timestamps
    end
  end
end
