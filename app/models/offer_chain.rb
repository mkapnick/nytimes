class OfferChain < ActiveRecord::Base
  attr_accessible :approved, :date
  has_many :nytfiles
  has_one :ticket

end
