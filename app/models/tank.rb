#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Tanks: sources of water
#
#       t.string  :name
#       t.integer :volume               # liters
#       t.integer :pump_pin
#       t.timestamps

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
        self.zones.planted.map { |z| z.needs_water }.include?(true)
    end

    def pump_on
#         RPi::GPIO.set_high self.pump_pin
      `python app/misc/python/set_pin_high.py ${self.pump_pin}`
      p "Turning on pump for #{self.name}"
    end

    def pump_off
#         RPi::GPIO.set_low self.pump_pin
      `python app/misc/python/set_pin_low.py ${self.pump_pin}`
      p "Turning off pump for #{self.name}"
    end

    # Callbacks
    after_save do
    #         RPi::GPIO.setup self.pump_pin, :as => :output
      `python app/misc/python/set_pin_outbound.py ${self.pump_pin}`
    end

end
