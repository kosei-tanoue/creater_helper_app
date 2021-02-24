class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_id, only: [:index]
  before_action :move_to_root, only: [:index]

  def index
    @message = Message.new
    # @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
  end
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

  def find_id
    @room = Room.find(params[:room_id])
  end

  def move_to_root
    unless @room.users.ids.include?(current_user.id)
      redirect_to root_path
    end
  end

end
