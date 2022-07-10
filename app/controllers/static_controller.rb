#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Static routes
#
class StaticController < ApplicationController

    def public_home
        @zones = Zone.all.ascending
        @tanks = Tank.all
    end

    def about
    end

    def credits
    end

    def legal
    end
end
