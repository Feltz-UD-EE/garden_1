#
# Copyright 2026 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Retrospectives: long-range summaries of crop and garden performance.
#
class RetrospectivesController < ApplicationController
  before_action :require_login

  def index
  end

  def crops
    @crops = Crop.alpha
  end

  def garden
    @zones = Zone.ascending
  end

  def harvests
    @events = Event.descending
  end

  def moisture
    @zones = Zone.ascending
  end

  private

    def require_login
      rodauth.require_authentication
    end
end
