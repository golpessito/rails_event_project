class UsersController < ApplicationController
  # load_and_authorize_resource
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :require_admin, only: [:index, :update, :edit]
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users=User.all
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @user.roles=params["user"]["roles"]
    respond_to do |format|
      if @user.update(event_params)
        format.html { redirect_to users_path, notice: 'User roles change successfully' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_url,  notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to users_url, alert: @user.errors.full_messages.join(',')}
        format.json { head :no_content }
      end
    end
  end

  private
    def require_admin
      redirect_to(root_url,alert: "You are not the Administrator.") unless (current_user.roles.include?(:admin))
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:user).permit(:roles_mask)
    end

end
