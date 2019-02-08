class ActiveItemsController < ApplicationController
  before_action :set_active_item, only: [:show, :edit, :update, :destroy]

  # GET /active_items
  # GET /active_items.json
  def index
    @active_items = ActiveItem.all
  end

  # GET /active_items/1
  # GET /active_items/1.json
  def show
  end

  # GET /active_items/new
  def new
    @active_item = ActiveItem.new
  end

  # GET /active_items/1/edit
  def edit
  end

  # POST /active_items
  # POST /active_items.json
  def create
    @active_item = ActiveItem.new(active_item_params)

    respond_to do |format|
      if @active_item.save
        format.html { redirect_to @active_item, notice: 'Active item was successfully created.' }
        format.json { render :show, status: :created, location: @active_item }
      else
        format.html { render :new }
        format.json { render json: @active_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /active_items/1
  # PATCH/PUT /active_items/1.json
  def update
    
  end

  # DELETE /active_items/1
  # DELETE /active_items/1.json
  def destroy
    @active_item.destroy
    respond_to do |format|
      format.html { redirect_to active_items_url, notice: 'Active item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_active_item
      @active_item = ActiveItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def active_item_params
      params.require(:active_item).permit(:lender_id, :borrower_id, :start_date, :due_date, :item_id)
    end
end
