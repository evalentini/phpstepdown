class DischargesController < ApplicationController
  
  layout "main"
  # GET /discharges
  # GET /discharges.json
  def index
    @discharges = Discharge.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @discharges }
    end
  end

  # GET /discharges/1
  # GET /discharges/1.json
  def show
    @discharge = Discharge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @discharge }
    end
  end

  # GET /discharges/new
  # GET /discharges/new.json
  def new
    @discharge = Discharge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @discharge }
    end
  end

  # GET /discharges/1/edit
  def edit
    @discharge = Discharge.find(params[:id])
  end

  # POST /discharges
  # POST /discharges.json
  def create
    @discharge = Discharge.new(params[:discharge])

    respond_to do |format|
      if @discharge.save
        format.html { redirect_to :controller => "discharges", :action => "index" }
        format.json { render json: @discharge, status: :created, location: @discharge }
      else
        format.html { render action: "new" }
        format.json { render json: @discharge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /discharges/1
  # PUT /discharges/1.json
  def update
    @discharge = Discharge.find(params[:id])

    respond_to do |format|
      if @discharge.update_attributes(params[:discharge])
        format.html { redirect_to :controller => "discharges", :action => "index"}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @discharge.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def hide
    @discharge = Discharge.find(params[:id])
    @discharge.update_attributes(:ishidden=>true)
    redirect_to :action => "index"
  end
  
  def unhide
    @discharge = Discharge.find(params[:id])
    @discharge.update_attributes(:ishidden=>false)
    redirect_to :action => "index"
  end
  
  def reasonsbyfacilityreport
    @period=Date.today.strftime("%m-%Y") 
    @period=params[:yrmonth] unless params[:yrmonth].nil?
    @pattype=params[:patienttype]
  end
  
  def mordata
  end
  
  def datadumpreport
  end

  # DELETE /discharges/1
  # DELETE /discharges/1.json
  def destroy
  #  @discharge = Discharge.find(params[:id])
  #  @discharge.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to discharges_url }
  #    format.json { head :no_content }
  #  end
  end
end
