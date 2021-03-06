class EventsController < ApplicationController
  respond_to :json

  def index
    respond_with Event.recent.within(query)
  end

  private

  def query
    params.permit(:latitude, :longitude, :radius)
  end
end
