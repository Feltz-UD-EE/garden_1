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
#       t.season  :integer
#       t.timestamps
#

# require 'rpi_gpio'

class Crop < ApplicationRecord
    # statics & enums
    enum season: { annual: 0, perennial: 1, overwinter: 2 }, _suffix: true

    # relations
    belongs_to :zone
    has_many :events

    # validations
    validates :name, presence: true
    validates :zone_id, presence: true

    # scopes
    scope :ascending, -> { order(plant_date: :asc) }
    scope :descending, -> { order(plant_date: :desc) }
    scope :this_year, -> {
        where("(season = 0 AND plant_date > date('now', 'start of year')) OR
                (season = 1) OR
                (season = 2 AND plant_date > date('now', 'start of year', '-1 year'))")
        }
    scope :current, -> { where("pull_date IS NULL") }
    scope :alpha, -> { order(name: :asc) }

    # class methods
    # used for summary crops-over-time views
    def harvests_by_year
        crop_hash = Hash.new
        Crop.all.each do |crop|
            end_year = (crop.current? ? Date.current.year : crop.pull_date.year)
#   do this stuff in rails c and figure it out
#            (crop.plant_date.year..end_year) do year
#                crop_hash.push("year": year, "crop": crop)
#            end
            crop_hash.push("year": end_year, "crop": crop)
        end
    end

    # instance methods
    def planted?
        (self.plant_date.present? &&
            Time.now() >= self.plant_date &&
            (self.pull_date.nil? || Time.now() < self.pull_date))
    end

    def total_harvest
        self.events.sum(:harvest).round(2)          # eliminate false precision due to float math errors
    end

    def total_harvest_this_year
        self.events.this_year.sum(:harvest).round(2)          # eliminate false precision due to float math errors
    end

    def description_pretty
        "#{self.name} #{self.description.present? ? '(' + self.description + ')' : ''} in zone #{self.zone.name}"
    end

    def description_pretty_short
        "#{self.name}#{self.description.present? ? ' (' + self.description + ')' : ''}"
    end

    # Callbacks
end

