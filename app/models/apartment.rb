class Apartment < ApplicationRecord
  has_many :tentants
  has_many :leases
end
