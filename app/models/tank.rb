#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Tanks: sources of water
#
# require 'rpi_gpio'

class Tank < ApplicationRecord
    # statics & enums

    # relations
    has_many :zones

    # validations
    validates :name, presence: true
    validates :pump_pin, presence: true

    # scopes

    # class methods

    # instance methods
    def needs_pumping
        self.zones.map { |z| z.needs_water }.include?(true)
    end

    def pump_on
        RPi::GPIO.setup self.pump_pin, :as => :output
        RPi::GPIO.set_high self.pump_pin
    end

    def pump_off
        RPi::GPIO.setup self.pump_pin, :as => :output
        RPi::GPIO.set_low self.pump_pin
    end

end
