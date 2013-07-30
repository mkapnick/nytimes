class Nytfile < ActiveRecord::Base
  attr_accessible :upload
  belongs_to :offer_chain
end
