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
    validates :zone_id, presence: true

    # scopes
    scope :ascending, -> { order(plant_date: :asc) }
    scope :descending, -> { order(plant_date: :desc) }

    # class methods
    # used for summary crops-over-time views
    def by_year
        crop_hash = Hash.new
        Crop.all.each do |crop|
            end_year = (crop.current? ? Date.current.year : crop.pull_date.year)
            (crop.plant_date.year..end_year) do year
                crop_hash.push("year": year, "crop": crop)
            end
        end
    end

    # instance methods
    def planted?
        (self.plant_date.present? &&
            Time.now() >= self.plant_date &&
            (self.pull_date.nil? || Time.now() < self.pull_date))
    end

    def total_harvest
        self.events.sum(:harvest)
    end

    # Callbacks
end

