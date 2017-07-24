class StoresController < ApplicationController
  before_action :find_store, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  
  expose :stores, ->{ Store.all.order('created_at DESC') }
  expose :store_products, ->{store.products}
  expose :store

  def index
  end

  def new
    authorize store
  end

  def create
    authorize store
    if store.save
      redirect_to store, notice: "Successfully"
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    authorize store
  end

  def update
    authorize store
    if store.update_attributes(store_params)
      redirect_to store_path(store), success: "Store Updated"
    else
      redirect_to store_path(store), success: "Unable to update store"
    end
  end

  def destroy
    authorize store
    if store.destroy
      redirect_to request.referrer, notice: "Store_deleted!"
    else
      redirect_to request.referrer, notice: "Unable to delete store!"
    end
  end

  private

    def store_params
      params.require(:store).permit(:company, :address)
    end
end
