class Nytfile < ActiveRecord::Base
  attr_accessible :uploads
  has_one :offer_chain
end
