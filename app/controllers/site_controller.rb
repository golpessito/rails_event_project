class SiteController < ApplicationController
  def home
    @events = Event.all
    render :layout => 'home'
  end
end
