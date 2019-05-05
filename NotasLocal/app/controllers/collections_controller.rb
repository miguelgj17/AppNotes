class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

# GET /collections
  # GET /collections.json
  def index
    if(session[:admin] == true)
      @collections = Collection.all
    else
      @collections = Collection.where(:user_id => [session[:user],"0"])
    end
  end


def create
    @collection = Collection.new(collection_params)

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    if @collection.user_id = session[:user] || (session[:admin] == true)
      @collection.destroy
      respond_to do |format|
        format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
        format.json { head :no_content }
        end
    else
      respond_to do |format|
        format.html { redirect_to collections_url, alert: 'You cannot delete another user’s collection!' }
        format.json { head :no_content }
      end
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:name, :user_id)
    end
end
