class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  def index
    items = Item.all
    render json: items, include: :user
  end

  def show
   item = Item.find(params[:id])
    render json: item, include: :user
  end

  def create
    item = Item.create(item_params)
    render json: item, status: :created
  end

  private

  def render_not_found_response
    render json: { error: "Item not found" }, 
    status: :not_found
  end

  def item_params
    params.permit(:user_id, :name, :description, :price)
  end

end

