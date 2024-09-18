class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy]

  # GET /lists
  def index
    @lists = List.all
    render json: @lists, include: :items
  end

  # GET /lists/:id
  def show
    render json: @list, include: :items
  end

    # POST /lists/:list_id/items
    def create
      @list = List.new(list_params) # Crie uma nova lista usando list_params

      if @list.save
        render json: @list, status: :created
      else
        render json: @list.errors, status: :unprocessable_entity
      end
    end


  # PATCH/PUT /lists/:id
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/:id
  def destroy
    @list.destroy
    head :no_content
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
