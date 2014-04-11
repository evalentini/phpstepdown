class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  
  before_filter :check_admin, :except => :index
  
  def check_admin
    if session[:adminpassword].present? 
      unless session[:adminpassword].nil?
        if Digest::SHA2.hexdigest(session[:adminpassword].to_s)==ENV['ADMIN_PASS_HASH'].to_s
        else
          redirect_to gate_path 
        end
      else
        redirect_to gate_path
      end
    else
      redirect_to gate_path
    end
  end
  
  def index
    @locations = Location.all
    @curpg = :admintools
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @curpg = :admintools
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @curpg = :admintools
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @curpg = :admintools
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @curpg = :admintools
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to :controller => "locations", :action => "index"  }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @curpg = :admintools
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to :controller => "locations", :action => "index" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def hide
    @curpg = :admintools
    @location = Location.find(params[:id])
    @location.update_attributes(:ishidden=>true)
    redirect_to :controller => "locations", :action => "index"
  end
  
  def unhide
    @curpg = :admintools
    @location = Location.find(params[:id])
    @location.update_attributes(:ishidden=>false)
    redirect_to :controller => "locations", :action => "index"
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  #should not be able to destroy locations, only hide them from view
  def destroy
#    @location = Location.find(params[:id])
#    @location.update_attributes(:ishidden => true)
#
#    respond_to do |format|
#      format.html { redirect_to locations_url }
#      format.json { head :no_content }
#    end
    
  end
end
