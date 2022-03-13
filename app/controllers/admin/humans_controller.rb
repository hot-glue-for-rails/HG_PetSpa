class Admin::HumansController < Admin::BaseController
  helper :hot_glue
  include HotGlue::ControllerHelper

  
  
  before_action :load_human, only: [:show, :edit, :update, :destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol ==  :turbo_stream }
 
  def load_human
    @human = (Human.find(params[:id]))
  end
  

  def load_all_humans 
    @humans = ( Human.page(params[:page]))  
  end

  def index
    load_all_humans
    respond_to do |format|
       format.html
    end
  end

  def new
    
    @human = Human.new()
   
    respond_to do |format|
      format.html
    end
  end

  def create
    modified_params = modify_date_inputs_on_params(human_params.dup)


    @human = Human.create(modified_params)

    if @human.save
      flash[:notice] = "Successfully created #{@human.name}"
      load_all_humans
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_humans_path }
      end
    else
      flash[:alert] = "Oops, your human could not be created."
      respond_to do |format|
        format.turbo_stream
        format.html
      end
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update

    if @human.update(modify_date_inputs_on_params(human_params))
      flash[:notice] = (flash[:notice] || "") << "Saved #{@human.name}"
    else
      flash[:alert] = (flash[:alert] || "") << "Human could not be saved."

    end

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def destroy
    begin
      @human.destroy
    rescue StandardError => e
      flash[:alert] = "Human could not be deleted"
    end
    load_all_humans
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to admin_humans_path }
    end
  end

  def human_params
    params.require(:human).permit( [:email, :name, :is_admin] )
  end

  def default_colspan
    3
  end

  def namespace
    "admin/" 
  end
end


