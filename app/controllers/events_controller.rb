class EventsController < ApplicationController
  # load_and_authorize_resource
  load_and_authorize_resource
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :require_author, only: [:edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index

    #Show the events where I have attended or I going to attend
    @my_assitances=current_user.events_to_attend

    #Show my events or if you are Administrator all events
    if current_user.roles.include? :admin
     @events = Event.all
    elsif current_user
     @events = Event.where(user_id:current_user)
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @rsvp = Rsvp.new
    @attendaces = nil
    @my_attendace = current_user.rsvps.where(event_id: @event.id) if current_user

    #Show the Attendes to this event if I am the author or I am Administrator
    if (current_user && (current_user.roles.include? :admin ) || (@event.user==current_user))
      @attendaces = @event.rsvps
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user=current_user if current_user

    respond_to do |format|
      if @event.save

        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        pp @event
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    respond_to do |format|
      if @event.destroy
        format.html { redirect_to events_url,  notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to events_url, alert: @event.errors.full_messages.join(',')}
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :address, :start_at, :end_at, :description, :photo)
    end

    def require_author
      redirect_to(root_url,alert: "You are not the Author of this event.") unless (@event.user == current_user || current_user.roles.include?(:admin))
    end

end
