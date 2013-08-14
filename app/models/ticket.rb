class Ticket < ActiveRecord::Base
  attr_accessible :description
  belongs_to :offerchain
end
