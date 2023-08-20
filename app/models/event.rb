#
# Copyright 2023 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Events: harvests and other crop-specific actions and observations
#

#
#     t.date    :date
#     t.string  :description
#     t.references :crop
#     t.float   :harvest
#     t.timestamps
#

class Event < ApplicationRecord
    # statics & enums

    # relations
    belongs_to :crop

    # validations
    validates :description, presence: true, unless: ->(event) { event.harvest.present? }
    validates :crop_id, presence: true

    # scopes
    scope :ascending, -> { order(date: :asc) }
    scope :descending, -> { order(date: :desc) }

    # class methods

    # instance methods

    # Callbacks

end

