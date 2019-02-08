class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :map]

  def index
    if logged_in?
      @items = Item.search(params[:search], params[:category_id], current_user.id).paginate(:page => params[:page])   
    else
      @items = Item.search(params[:search], params[:category_id], nil).paginate(:page => params[:page])   
    end
    flash[:keyword] = params[:search]
    flash[:category_id] = params[:category_id]
    
  end

  def new
    @item = Item.new
    @categories = Category.order(:name)
  end

  def create

    #initialize the new item
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    @item.taken = false
    @item.available = true
    @item.times_used = 0
    if @item.save {
      @item.item_id = @item.id
      redirect_to items_path
    }
    else
      @categories = Category.all
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
    @request = Request.new
    if @item.available == false
      redirect_to items_path
    end


    
  end

  def edit
    #TODO
  end

  def update
    #TODO
  end

  def destroy
    #TODO
  end

  def item_returned
    @item_returned = Item.find(params[:id])

    #make the taken  to false
    @item_returned.taken = false;
    @item_returned.save

    #set the request of the item to be done
    @corresponding_request = Request.where(:item_id => @item_returned.id, :status => 'accepted').limit(1)
    @request = @corresponding_request.first
    @request.status = 'done'
    @request.responded_on = DateTime.current
    @request.save

    #delete the active item record
    ActiveItem.delete(item_id: params[:id])

  end

  def hide_item_from_listings
    @item = Item.find(params[:id])

    #make the  availablity to false
    @item.available = false;
    @item.save

  end

  def unhide_item_from_listings
    @item = Item.find(params[:id])

    #make the  availablity to true
    @item.available = true;
    @item.save

  end

  def delete_item_from_listings
    @item = Item.find(params[:id])

    #make the  availablity to false
    @item.available = false;
    @item.is_deleted = true;
    @item.save

  end


  def map
    if logged_in?
      @items = Item.search(flash[:keyword], flash[:category_id], current_user.id)

    else
      @items = Item.search(flash[:keyword], flash[:category_id], nil)  
    end
  end

  private
  def item_params
    params.require(:item).permit(:description, :category_id, :image)
  end
end
