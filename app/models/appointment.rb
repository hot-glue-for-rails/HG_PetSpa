class Appointment < ApplicationRecord

  belongs_to :pet, optional: false

  has_one :human, through: :pet

  def name
    "for #{pet.try(:name)} @ #{when_at}"
  end
end
