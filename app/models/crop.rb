#
# Copyright 2023 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Crops: individual species & varietes of plant
#

#
#       t.string  :name
#       t.string  :description
#       t.references :zone
#       t.date    :plant_date
#       t.date    :pull_date
#       t.timestamps
#

# require 'rpi_gpio'

class Crop < ApplicationRecord
    # statics & enums

    # relations
    belongs_to :zone
    has_many :events

    # validations
    validates :name, presence: true

    # scopes
    scope :ascending, -> { order(number: :asc) }

    # class methods

    # instance methods
    def planted?
        (self.plant_date.present? &&
            Time.now() >= self.plant_date &&
            (self.pull_date.nil? || Time.now() < self.pull_date))
    end

    def total_harvest
        self.crops.sum(:harvest)
    end

    # Callbacks
end

