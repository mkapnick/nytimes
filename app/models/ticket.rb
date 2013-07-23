class Ticket < ActiveRecord::Base
  attr_accessible :description
  has_one :offer_chain

end
