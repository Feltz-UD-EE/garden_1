#
# Copyright 2023 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Notes: general descriptions of work performed or garden condition
#

#
#     t.date    :date
#     t.text  :description
#     t.timestamps
#

class Note < ApplicationRecord
    # statics & enums

    # relations

    # validations
    validates :description, presence: true

    # scopes
    scope :ascending, -> { order(created_timestamp: :asc) }
    scope :descending, -> { order(created_timestamp: :desc) }
    scope :this_year, -> { where("date > date('now', 'start of year')") }

    # class methods

    # instance methods

    # Callbacks

end

