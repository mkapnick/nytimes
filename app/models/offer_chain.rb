class OfferChain < ActiveRecord::Base
  attr_accessible :approved, :date
  has_many :nytfiles
  has_many :tickets

end
