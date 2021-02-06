class RoomsController < ApplicationController
  before_action :authenticate_user!


  def index
  end
  
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      # binding.pry
      redirect_to "/rooms/#{@room.id}/messages"
    else
      render :new
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to "/rooms"
  end


  private

  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end




end
