#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Static routes
#
class StaticController < ApplicationController

    def home
        render "/public_home"
    end

    def about
        render "/about"
    end

    def credits
        render "/credits"
    end

    def legal
        render "/legal"
    end
end
