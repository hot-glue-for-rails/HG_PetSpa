class Pet < ApplicationRecord
  belongs_to :human

  has_many :appointments


end
