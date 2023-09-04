#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Static routes
#
class StaticController < ApplicationController

    def public_home
        @zones = Zone.all.ascending
        @tanks = Tank.all
        @total_harvest = 0
        @tank.each do |tank|
            @total_harvest += tank.total_harvest
        end
    end

    def about
    end

    def credits
    end

    def legal
    end
end
