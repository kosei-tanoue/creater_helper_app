class RequestsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_request, only: [:edit, :show, :update]
  before_action :move_to_root, only: [:edit]


  def index
    @requests = Request.includes(:user).order("created_at desc")
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)

    if @request.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    request = Request.find(params[:id])
    if request.destroy
      redirect_to requests_path
    end
  end

  def edit
    
  end

  def update

    if @request.update(request_params)
      redirect_to requests_path
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @request.comments.includes(:user)
  end


  private
  def request_params
    params.require(:request).permit(:title, :text, :category_id).merge(user_id: current_user.id)
  end

  def set_request
    @request = Request.find(params[:id])
  end

  def move_to_root
    if current_user.id != @request.user_id
      redirect_to root_path
    end
  end
end
