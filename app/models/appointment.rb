class Appointment < ApplicationRecord

  belongs_to :pet

  has_one :human, through: :pet

  def name
    "for #{pet.name} @ #{when_at}"
  end
end
