class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, only: [ :show, :update, :destroy ]

  def by_date
    date = params[:date]
    @items = @list.items.where(date: date)
    render json: @items
  end



  def index
    if params[:start_date] && params[:end_date]
      @items = @list.items.where(date: params[:start_date]..params[:end_date])
    else
      @items = @list.items
    end
    render json: @items
  end


  # GET /lists/:list_id/items/:id
  def show
    render json: @item
  end

  # POST /lists/:list_id/items
  def create
    @item = @list.items.new(item_params)

    if @item.save
      render json: @item, status: :created
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/:list_id/items/:id
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/:list_id/items/:id
  def destroy
    @item.destroy
    head :no_content
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_item
    @item = @list.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:description, :completed, :date)
  end
end
