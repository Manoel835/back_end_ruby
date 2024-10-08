class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  def by_date
    date = params[:date]
    @items = Item.where(list_id: params[:list_id], date: date)
    render json: @items
  end

  def index
    if params[:start_date] && params[:end_date]
      @items = Item.where(list_id: params[:list_id], date: params[:start_date]..params[:end_date])
    else
      @items = Item.where(list_id: params[:list_id])
    end
    render json: @items
  end

  # GET /lists/:list_id/items/:id
  def show
    render json: @item
  end

  # POST /lists/:list_id/items
  def create
    @item = Item.new(item_params)
    @item.list_id = params[:list_id]

    # Ajustar a data para o fuso horário local
    if @item.date.present?
      @item.date = @item.date.in_time_zone(Time.zone).to_date
    end

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

  def set_item
    @item = Item.find(params[:id]) # Buscar o item globalmente
  end

  def item_params
    params.require(:item).permit(:description, :completed, :date, :list_id)
  end
end
