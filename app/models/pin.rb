#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Models Raspberry Pi pinouts
#
class Pin < ApplicationRecord
    # statics & enums
    def self.PINRANGE
        [*1..40]
    end

    # relations
    has_one :sensor         # both of these are tentative - if I have to multiplex or otherwise
    has_one :actuator       # deal with something other than 1-1 relationship I'll have to scrap
                            # this and do polymorphic or something

    # validations
    validates :number, presence: true
    validates :number, inclusion: { in: self.PINRANGE, message: "%{value} is not in the range %{self.PINRANGE}"}
    validates :gpio, uniqueness: true, allow_nil: true

    # scopes
    def self.default_scope
        order(number: :asc)
    end

    # methods

end
