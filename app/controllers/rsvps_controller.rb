class RsvpsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rsvp, only: [:destroy]

  def new
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)
    @rsvp.attende=current_user

    respond_to do |format|
      if @rsvp.save
        AttendToEventJob.perform_later(current_user,@rsvp.events_to_attend)
        format.html { redirect_to @rsvp.events_to_attend, notice: 'You are going to attend this event!! Thanks' }
        format.json { render :show, status: :created, location: @rsvp }
      else
        format.html { redirect_to @rsvp.events_to_attend, alert: 'You can\'t attend to this event, check if you are not already attending.' }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @rsvp.destroy
        format.html { redirect_to @rsvp.events_to_attend, notice: 'The user attendance has been deleted' }
        format.json { render :show, status: :created, location: @rsvp }
      else
        format.html { redirect_to @rsvp.events_to_attend, alert: 'You can\'t attend to this event, check if you are not already attending.' }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def index
  end

  private

    def set_rsvp
      @rsvp=Rsvp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rsvp_params
      params.require(:rsvp).permit(:event_id)
    end

end
