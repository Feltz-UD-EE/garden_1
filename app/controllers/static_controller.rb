#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Static routes
#
class StaticController < ApplicationController

    def public_home
        @zones = Zone.all.ascending
        @tanks = Tank.all
        t = 0
        @tanks.each do |tank|
            t += tank.total_harvest_this_year
        end
        @total_harvest = t.round(2)          # eliminate false precision due to float math errors
        @notes = Note.descending.this_year.limit(30)
    end

    def about
    end

    def credits
    end

    def legal
    end
end
